-- Users
INSERT INTO Users (UserID, Name, Email, Phone)
VALUES
(1, 'Ali Rezaei', 'ali@example.com', '09121234567'),
(2, 'Sara Ahmadi', 'sara@example.com', '09127654321');

-- Tickets
INSERT INTO Tickets (TicketID, UserID, EventName, EventDate, SeatNumber, Price)
VALUES
(1, 1, 'Concert A', '2025-06-01 20:00:00', 'A12', 300.00),
(2, 2, 'Movie B', '2025-06-02 18:30:00', 'B05', 120.00);

-- Reservations
INSERT INTO Reservations (ReservationID, UserID, TicketID, ReservationDate)
VALUES
(1, 1, 1, '2025-05-01 10:00:00'),
(2, 2, 2, '2025-05-02 11:00:00');

-- Payments
INSERT INTO Payments (PaymentID, ReservationID, PaymentDate, Amount, Method)
VALUES
(1, 1, '2025-05-01 11:00:00', 300.00, 'Credit Card'),
(2, 2, '2025-05-02 12:00:00', 120.00, 'Paypal');

-- Reports
INSERT INTO Reports (ReportID, UserID, ReportText, CreatedAt)
VALUES
(1, 1, 'Ticket was not delivered on time.', '2025-05-03 15:00:00'),
(2, 2, 'Seat was already taken.', '2025-05-04 18:00:00');
