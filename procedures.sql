DROP PROCEDURE IF EXISTS GetMaxQuantity;

DELIMITER //
SELECT MAX(total_qty) AS "Max Quantity in Order" 
FROM ( SELECT OrderID, SUM(Quantity) AS total_qty FROM OrderItems GROUP BY OrderID ) t;
CREATE PROCEDURE GetMaxQuantity() BEGIN  

END//

DELIMITER ;

CALL GetMaxQuantity();

DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER $$
CREATE PROCEDURE CancelOrder(IN p_OrderID INT)
BEGIN
DECLARE v_exists INT;

SELECT COUNT(*) INTO v_exists FROM Orders WHERE OrderID = p_OrderID;
IF (v_exists>0) then
DELETE FROM OrderItems WHERE OrderID = p_OrderID;
DELETE FROM Orders WHERE OrderID = p_OrderID;
Select CONCAT('successfully deleted order ', p_OrderID);
else
	Select "Order not found";
end if;
end$$

DELIMITER ;

Call CancelOrder(9999);


DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`(
  IN p_BookingDateTime DATETIME,
  IN p_TableNumber INT,
  IN p_CustomerID INT
)
BEGIN
  DECLARE v_count INT;

  SELECT COUNT(*) INTO v_count
  FROM Bookings b
  WHERE b.BookingDateTime = p_BookingDateTime
    AND b.TableNumber = p_TableNumber;

  IF v_count = 0 THEN
    INSERT INTO Bookings (BookingDateTime, TableNumber, CustomerID)
    VALUES (p_BookingDateTime, p_TableNumber, p_CustomerID);

    SELECT 'Table booked successfully' AS Result;
  ELSE
    SELECT 'Sorry, table is not available' AS Result;
  END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckBooking`(IN p_BookingDateTime DATETIME, IN p_TableNumber INT)
BEGIN
  DECLARE v_count INT;

  SELECT COUNT(*) INTO v_count
  FROM Bookings b
  WHERE b.BookingDateTime = p_BookingDateTime
    AND b.TableNumber = p_TableNumber;

  IF v_count > 0 THEN
    SELECT CONCAT('Table ', p_TableNumber, ' is already booked at ', p_BookingDateTime) AS BookingStatus;
  ELSE
    SELECT CONCAT('Table ', p_TableNumber, ' is available at ', p_BookingDateTime) AS BookingStatus;
  END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelBooking`(IN p_BookingID INT)
BEGIN 
DECLARE v_exists INT;
DECLARE v_table_number INT;
SELECT COUNT(*) INTO v_exists FROM Bookings WHERE BookingID = p_BookingID;
IF (v_exists>0) then

	Select TableNumber into v_table_number FROM Bookings WHERE BookingID = p_BookingID;
	DELETE FROM Bookings WHERE BookingID = p_BookingID;
	Select CONCAT('successfully deleted booking for table ', v_table_number);
else
	Select "Table not found";
end if;
end$$
DELIMITER ;

DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBooking`(
  IN p_BookingID INT,
  IN p_NewBookingDateTime DATETIME,
  IN p_NewTableNumber INT
)
BEGIN
  DECLARE v_exists INT;
  DECLARE v_conflict INT;

  SELECT COUNT(*) INTO v_exists
  FROM Bookings
  WHERE BookingID = p_BookingID;

  IF v_exists = 0 THEN
    SELECT 'BookingID not found' AS Result;
  ELSE
    SELECT COUNT(*) INTO v_conflict
    FROM Bookings
    WHERE BookingDateTime = p_NewBookingDateTime
      AND TableNumber = p_NewTableNumber
      AND BookingID <> p_BookingID;

    IF v_conflict > 0 THEN
      SELECT 'Sorry, that date/time and table are already booked' AS Result;
    ELSE
      UPDATE Bookings
      SET BookingDateTime = p_NewBookingDateTime,
          TableNumber = p_NewTableNumber
      WHERE BookingID = p_BookingID;

      SELECT 'Booking updated successfully' AS Result;
    END IF;
  END IF;
END$$
DELIMITER ;


