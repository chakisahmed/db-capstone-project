DEALLOCATE PREPARE GetOrderDetail;
PREPARE GetOrderDetail FROM 'SELECT o.OrderID, o.TotalCost, SUM(oi.Quantity) FROM Orders o JOIN OrderItems oi ON o.OrderID = oi.OrderID WHERE o.customerID = ? GROUP BY o.OrderID, o.TotalCost;';
SET @id = 1; 
EXECUTE GetOrderDetail USING @id;