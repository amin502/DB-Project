using System.ComponentModel.DataAnnotations;

namespace TicketSystem.Models
{
    public class SignupViewModel
    {
        [Required]
        public string FullName { get; set; }

        [Required]
        public string PhoneNumber { get; set; }

        [EmailAddress]
        public string Email { get; set; }

        public string Gender { get; set; }
    }
}
