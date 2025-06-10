namespace TicketSystem.Models
{
    public class ReserveTicketViewModel
    {
        public int TicketId { get; set; }
        public string Origin { get; set; }
        public string Destination { get; set; }
        public DateTime TravelDate { get; set; }
        public int Price { get; set; }
    }
}
