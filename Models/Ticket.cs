namespace TicketSystem.Models
{
    public class Ticket
    {
        public int Id { get; set; }
        public string Origin { get; set; }
        public string Destination { get; set; }
        public DateTime TravelDate { get; set; }
        public int Price { get; set; }
        public string TransportType { get; set; } // اتوبوس، قطار، هواپیما
        public int Capacity { get; set; }
    }
}
