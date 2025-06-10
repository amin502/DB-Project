using System.Net.Sockets;

namespace TicketSystem.Models
{
    public class Reservation
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int TicketId { get; set; }
        public DateTime ReservedAt { get; set; } = DateTime.Now;
        public DateTime ExpiresAt { get; set; }
        public string Status { get; set; } = "Pending";

        public User User { get; set; }
        public Ticket Ticket { get; set; }
    }

}
