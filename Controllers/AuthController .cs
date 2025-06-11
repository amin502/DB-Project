using Microsoft.AspNetCore.Mvc;
using System;
using TicketSystem.Data;
using TicketSystem.Models;

namespace TicketSystem.Controllers
{
    public class AuthController : Controller
    {

        private readonly AppDbContext _db;

        public AuthController(AppDbContext db)
        {
            _db = db;
        }

        [HttpGet("/auth/send-otp")]
        public IActionResult SendOtp() => View();

        [HttpPost("/auth/send-otp")]
        public IActionResult SendOtp(string phoneNumber)
        {
            var otp = new Random().Next(100000, 999999).ToString();

            TempData["PhoneNumber"] = phoneNumber;
            TempData["OtpCode"] = otp;

            Console.WriteLine($"OTP for {phoneNumber}: {otp}");

            return RedirectToAction("VerifyOtp");
        }

        [HttpGet("/auth/verify-otp")]
        public IActionResult VerifyOtp() => View();

        [HttpPost("/auth/verify-otp")]
        public IActionResult VerifyOtp(string otpCode)
        {
            string expectedOtp = TempData["OtpCode"] as string;
            string phoneNumber = TempData["PhoneNumber"] as string;

            if (otpCode == expectedOtp)
            {
                // بعداً: ثبت کاربر در دیتابیس یا ورود
                return RedirectToAction("Search", "Ticket");
            }

            ModelState.AddModelError("", "کد وارد شده نادرست است.");
            return View();
        }
        [HttpGet("/auth/signup")]
        public IActionResult Signup()
        {
            var phone = TempData["PhoneNumber"] as string;
            if (phone == null) return RedirectToAction("SendOtp");

            return View(new SignupViewModel { PhoneNumber = phone });
        }

        [HttpPost("/auth/signup")]
        public IActionResult Signup(SignupViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var user = new User
            {
                FullName = model.FullName,
                PhoneNumber = model.PhoneNumber,
                Email = model.Email,
                Gender = model.Gender
            };

            _db.Users.Add(user);
            _db.SaveChanges();

            TempData["UserId"] = user.Id;
            return RedirectToAction("Search", "Ticket");
        }

        

    }
}
