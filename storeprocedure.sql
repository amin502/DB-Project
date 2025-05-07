-- 1. با دریافت ایمیل یا شماره تلفن، لیست بلیت‌های خریداری‌شده توسط کاربر را به ترتیب زمان خرید نمایش دهید.
CREATE PROCEDURE ShowUserTicketsByContact
    @Contact NVARCHAR(100)
AS
BEGIN
    SELECT t.*, r.ReservedAt
    FROM [User] u
    JOIN Reservation r ON u.UserID = r.UserID
    JOIN Ticket t ON r.TicketID = t.TicketID
    WHERE u.PhoneNumber = @Contact 
    ORDER BY r.ReservedAt;
END;



-- 2. با دریافت ایمیل یا شماره تلفن پشتیبان، نام کاربرانی که حداقل یک‌بار رزرو آن‌ها لغو شده را لیست کنید.
CREATE PROCEDURE ShowCancelledBySupport
    @SupportContact NVARCHAR(100)
AS
BEGIN
    SELECT DISTINCT u2.FirstName, u2.LastName
    FROM [User] u1
    JOIN Reservation r ON u1.UserID = r.UserID
    JOIN [User] u2 ON r.UserID = u2.UserID
    WHERE u1.Role = 'admin' AND (u1.PhoneNumber = @SupportContact)
    AND r.ReservationStatus = 'cancelled';
END;



-- 3. با دریافت نام شهر، لیست بلیت‌های خریداری‌شده در آن شهر را نمایش دهید.
CREATE PROCEDURE ShowTicketsByCity
    @City NVARCHAR(100)
AS
BEGIN
    SELECT t.*
    FROM Ticket t
    JOIN Reservation r ON r.TicketID = t.TicketID
    WHERE t.OriginCity = @City OR t.DestinationCity = @City;
END;



-- 4. عبارتی را از ورودی گرفته و بلیت‌هایی را که آن عبارت در نام مسافر، مسیر سفر یا کلاس بلیت آمده باشد را برگردانید.
CREATE PROCEDURE SearchTicketsByKeyword
    @Keyword NVARCHAR(100)
AS
BEGIN
    SELECT t.*
    FROM Ticket t
    JOIN Reservation r ON t.TicketID = r.TicketID
    JOIN [User] u ON r.UserID = u.UserID
    WHERE u.FirstName LIKE '%' + @Keyword + '%'
       OR u.LastName LIKE '%' + @Keyword + '%'
       OR t.OriginCity LIKE '%' + @Keyword + '%'
       OR t.DestinationCity LIKE '%' + @Keyword + '%'
       OR t.TravelClass LIKE '%' + @Keyword + '%';
END;

-- 7. با دریافت نوع وسیله نقلیه، لیست بلیت‌های کنسل‌شده مربوط به آن را به ترتیب تاریخ نمایش دهید.
CREATE PROCEDURE ShowCancelledTicketsByVehicle
    @VehicleType NVARCHAR(20)
AS
BEGIN
    SELECT t.*, r.ReservedAt
    FROM Ticket t
    JOIN Reservation r ON r.TicketID = t.TicketID
    WHERE t.VehicleType = @VehicleType
      AND r.ReservationStatus = 'cancelled'
    ORDER BY r.ReservedAt;
END;


-- 8. با دریافت موضوع گزارش، لیست کاربرانی که بیشترین گزارش در آن موضوع دارند را نمایش دهید.
CREATE PROCEDURE ShowTopReportUsersByCategory
    @Category NVARCHAR(50)
AS
BEGIN
    SELECT TOP 5 u.FirstName, u.LastName, COUNT(*) AS ReportCount
    FROM [User] u
    JOIN Report r ON r.UserID = u.UserID
    WHERE r.Category = @Category
    GROUP BY u.FirstName, u.LastName
    ORDER BY ReportCount DESC;
END;