using Microsoft.AspNetCore.Mvc;
using TicketSystem.Data;
using System.Linq;
using TicketSystem.Models;
using Microsoft.EntityFrameworkCore;

namespace TicketSystem.Controllers
{
    public class TicketController : Controller
    {
        private readonly AppDbContext _db;

        public TicketController(AppDbContext db)
        {
            _db = db;
        }

        [HttpGet("/tickets/search")]
        public IActionResult Search(string origin, string destination, DateTime? travelDate)
        {
            var query = _db.Tickets.AsQueryable();

            if (!string.IsNullOrWhiteSpace(origin))
                query = query.Where(t => t.Origin.Contains(origin));
            if (!string.IsNullOrWhiteSpace(destination))
                query = query.Where(t => t.Destination.Contains(destination));
            if (travelDate.HasValue)
                query = query.Where(t => t.TravelDate.Date == travelDate.Value.Date);
            var cities = _db.Tickets
                   .Select(t => t.Origin)
                   .Union(_db.Tickets.Select(t => t.Destination))
                   .Distinct()
                   .ToList();

                        ViewBag.Cities = cities;

            var result = query.ToList();
            return View(result);
        }

        [HttpPost("/tickets/confirm-reservation")]
        public IActionResult ConfirmReservation(int ticketId)
        {
            int userId = Convert.ToInt32(TempData["UserId"]); // یا از Session

            var reservation = new Reservation
            {
                TicketId = ticketId,
                UserId = userId,
                ReservedAt = DateTime.Now,
                ExpiresAt = DateTime.Now.AddMinutes(10)
            };

            _db.Reservations.Add(reservation);
            _db.SaveChanges();

            return RedirectToAction("MyReservations");
        }

        [HttpGet("/tickets/my-reservations")]
        public IActionResult MyReservations()
        {
            int userId = Convert.ToInt32(TempData["UserId"]); // یا از Session


            var reservations = _db.Reservations
                .Include(r => r.Ticket)
                .Where(r => r.UserId == userId)
                .OrderByDescending(r => r.ReservedAt)
                .ToList();

            return View(reservations);
        }


        [HttpGet("/tickets/reserve")]
        public IActionResult Reserve(int ticketId)
        {
            var ticket = _db.Tickets.FirstOrDefault(t => t.Id == ticketId);
            if (ticket == null)
                return NotFound();

            var vm = new ReserveTicketViewModel
            {
                TicketId = ticket.Id,
                Origin = ticket.Origin,
                Destination = ticket.Destination,
                TravelDate = ticket.TravelDate,
                Price = ticket.Price
            };

            return View(vm);
        }

        [HttpPost("/tickets/pay")]
        [ValidateAntiForgeryToken]
        public IActionResult PayReservation(int id)
        {
            var reservation = _db.Reservations.FirstOrDefault(r => r.Id == id);

            if (reservation == null)
                return NotFound();

            reservation.Status = "Paid";
            _db.SaveChanges();

            return RedirectToAction("MyReservations");
        }
    }
}
