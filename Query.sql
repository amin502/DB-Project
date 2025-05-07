

-- 1. نام و نام خانوادگی کاربرانی را برگردانید که تا به حال هیچ بلیطی رزرو نکرده‌اند.
SELECT FirstName, LastName
FROM [User]
WHERE UserID NOT IN (
    SELECT DISTINCT UserID FROM Reservation
);


-- 2. نام و نام خانوادگی تمام کاربرانی که حداقل یک بلیط خریده‌اند را بدست آورید.
SELECT DISTINCT u.FirstName, u.LastName
FROM [User] u
JOIN Reservation r ON u.UserID = r.UserID
WHERE r.ReservationStatus = 'paid';


-- 3. مجموع پرداخت‌های انجام‌شده توسط هر کاربر را در ماه‌های مختلف برگردانید.
SELECT 
    u.FirstName,
    u.LastName,
    YEAR(p.PaidAt) AS PayYear,
    MONTH(p.PaidAt) AS PayMonth,
    SUM(p.Amount) AS TotalPaid
FROM Payment p
JOIN [User] u ON p.UserID = u.UserID
GROUP BY u.FirstName, u.LastName, YEAR(p.PaidAt), MONTH(p.PaidAt);



-- 5. اطلاعات کاربری را برگردانید که جدیدترین بلیط را خریداری کرده است.
SELECT TOP 1 u.*
FROM [User] u
JOIN Reservation r ON u.UserID = r.UserID
ORDER BY r.ReservedAt DESC;



-- 6. شماره تلفن یا ایمیل کاربرانی که مجموع پرداخت‌های آن‌ها بیشتر از میانگین پرداخت کل کاربران باشد را برگردانید.
SELECT u.PhoneNumber, u.Email
FROM [User] u
JOIN Payment p ON u.UserID = p.UserID
GROUP BY u.PhoneNumber, u.Email
HAVING SUM(p.Amount) > (SELECT AVG(Total) FROM (
    SELECT SUM(Amount) AS Total
    FROM Payment
    GROUP BY UserID
) AS UserTotals);

-- 7. تعداد بلیط‌های فروخته‌شده به ازای هر نوع وسیله نقلیه (هواپیما، قطار، اتوبوس) را نمایش دهید.
SELECT t.VehicleType, COUNT(*) AS TicketsSold
FROM Ticket t
JOIN Reservation r ON r.TicketID = t.TicketID
GROUP BY t.VehicleType;



-- 8. نام ۳ کاربر با بیشترین خرید بلیط در هفته اخیر را برگردانید.
SELECT TOP 3 u.FirstName, u.LastName, COUNT(*) AS Total
FROM [User] u
JOIN Reservation r ON u.UserID = r.UserID
WHERE r.ReservedAt >= DATEADD(DAY, -7, GETDATE())
GROUP BY u.FirstName, u.LastName
ORDER BY Total DESC;


-- 9. تعداد بلیط‌های فروخته‌شده در استان تهران را به تفکیک شهر نمایش دهید.
SELECT t.OriginCity, COUNT(*) AS TicketsSold
FROM Ticket t
JOIN Reservation r ON r.TicketID = t.TicketID
WHERE t.OriginCity LIKE 'Tehran'
GROUP BY t.OriginCity;



-- 10. نام شهرهایی که قدیمی‌ترین کاربر ثبت‌نام‌شده در سیستم از آنجا خرید داشته است را لیست کنید.
SELECT DISTINCT t.OriginCity
FROM Ticket t
JOIN Reservation r ON r.TicketID = t.TicketID
WHERE r.UserID = (
    SELECT TOP 1 UserID FROM [User] ORDER BY UserID ASC
);


-- 11. نام پشتیبان‌های سایت را لیست کنید.
SELECT FirstName, LastName
FROM [User]
WHERE Role = 'admin' OR Role = 'support';


-- 12. نام کاربرانی که حداقل ۲ بلیط در سیستم خریداری کرده‌اند را برگردانید.
SELECT u.FirstName, u.LastName
FROM [User] u
JOIN Reservation r ON u.UserID = r.UserID
GROUP BY u.FirstName, u.LastName
HAVING COUNT(*) >= 2;



-- 13. نام کاربرانی را لیست کنید که حداکثر ۲ بلیط از یک وسیله نقلیه خاص (مثلاً قطار) خریده‌اند.
SELECT u.FirstName, u.LastName
FROM [User] u
JOIN Reservation r ON u.UserID = r.UserID
JOIN Ticket t ON r.TicketID = t.TicketID
WHERE t.VehicleType = 'train'
GROUP BY u.FirstName, u.LastName
HAVING COUNT(*) <= 2;



-- 14. ایمیل یا شماره تلفن کاربرانی که از تمام وسایل نقلیه (هواپیما، قطار، اتوبوس) حداقل یک بار بلیط خریده‌اند را برگردانید.
SELECT  u.PhoneNumber
FROM [User] u
WHERE
    EXISTS (
        SELECT 1 FROM Reservation r
        JOIN Ticket t ON r.TicketID = t.TicketID
        WHERE r.UserID = u.UserID AND t.VehicleType = 'flight'
    )
    AND EXISTS (
        SELECT 1 FROM Reservation r
        JOIN Ticket t ON r.TicketID = t.TicketID
        WHERE r.UserID = u.UserID AND t.VehicleType = 'train'
    )
    AND EXISTS (
        SELECT 1 FROM Reservation r
        JOIN Ticket t ON r.TicketID = t.TicketID
        WHERE r.UserID = u.UserID AND t.VehicleType = 'bus'
    );



-- 15. اطلاعات بلیط‌های خریداری‌شده امروز را با ترتیب ساعت خرید لیست کنید.
SELECT t.*, r.ReservedAt
FROM Ticket t
JOIN Reservation r ON r.TicketID = t.TicketID
WHERE CAST(r.ReservedAt AS DATE) = CAST(GETDATE() AS DATE)
ORDER BY r.ReservedAt;

-- 16. دومین بلیط پرفروش در بین کل بلیط‌ها را نمایش دهید.
SELECT TOP 1 TicketID, COUNT(*) AS TotalSold
FROM Reservation
WHERE TicketID NOT IN (
    SELECT TOP 1 TicketID
    FROM Reservation
    GROUP BY TicketID
    ORDER BY COUNT(*) DESC
)
GROUP BY TicketID
ORDER BY TotalSold DESC;


-- 17. نام پشتیبان با بیشترین تعداد لغو رزرو بلیط، همراه با درصد لغوها را برگردانید.
SELECT TOP 1 u.FirstName, u.LastName,
       COUNT(*) AS CancelledCount,
       CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM Reservation) * 100 AS CancelPercent
FROM [User] u
JOIN Reservation r ON u.UserID = r.UserID
WHERE u.Role = 'admin' AND r.ReservationStatus = 'cancelled'
GROUP BY u.FirstName, u.LastName
ORDER BY CancelledCount DESC;

-- 18. نام خانوادگی کاربری که بیشترین تعداد بلیط کنسل‌شده دارد را به "ردینگتون" تغییر دهید.
UPDATE [User]
SET LastName = N'ردینگتون'
WHERE UserID = (
    SELECT TOP 1 UserID
    FROM Reservation
    WHERE ReservationStatus = 'cancelled'
    GROUP BY UserID
    ORDER BY COUNT(*) DESC
);


-- 19. تمام بلیط‌های کنسل‌شده کاربر "ردینگتون" را حذف کنید.
DELETE FROM Reservation
WHERE ReservationStatus = 'cancelled'
AND UserID = (
    SELECT UserID FROM [User]
    WHERE LastName = N'ردینگتون'
);


-- 20. تمام بلیط‌های کنسل‌شده در سیستم را پاک کنید.
DELETE FROM Reservation
WHERE ReservationStatus = 'cancelled';


-- 21. 
UPDATE Ticket
SET Price = Price * 0.9
WHERE CarrierCompany LIKE N'%ماهان%'
AND CAST(DepartureTime AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE);


-- 22. موضوع و تعداد گزارش‌ها را برای بلیطی که بیشترین تعداد گزارش دارد، نمایش دهید.
SELECT TOP 1 t.TicketID, r.Category, COUNT(*) AS ReportCount
FROM Report r
JOIN Reservation rs ON r.ReservationID = rs.ReservationID
JOIN Ticket t ON rs.TicketID = t.TicketID
GROUP BY t.TicketID, r.Category
ORDER BY ReportCount DESC;

