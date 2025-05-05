-- نمایش اطلاعات کاربران و رزروها
SELECT u.FirstName, u.LastName, u.Email, r.ReservationDate, t.EventName, t.SeatNumber
FROM Users u
JOIN Reservations r ON u.UserID = r.UserID
JOIN Tickets t ON r.TicketID = t.TicketID;

-- مجموع مبلغ پرداختی هر کاربر
SELECT CONCAT(u.FirstName, ' ', u.LastName) AS FullName, SUM(p.Amount) AS TotalPaid
FROM Users u
JOIN Reservations r ON u.UserID = r.UserID
JOIN Payments p ON r.ReservationID = p.ReservationID
GROUP BY u.UserID;

-- گزارش‌های کاربران
SELECT CONCAT(u.FirstName, ' ', u.LastName) AS FullName, r.ReportText, r.CreatedAt
FROM Reports r
JOIN Users u ON r.UserID = u.UserID;
