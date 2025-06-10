using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class User
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    public string FullName { get; set; }

    [Required]
    public string PhoneNumber { get; set; }

    [EmailAddress]
    public string Email { get; set; }

    public string Gender { get; set; }

    public DateTime RegisterDate { get; set; } = DateTime.Now;
}
