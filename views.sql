CREATE OR REPLACE VIEW OrdersSalesSummary AS 
select o.OrderID AS OrderID,
concat(c.FirstName,' ',c.LastName) AS CustomerName,
o.OrderDateTime AS OrderDateTime,
o.TotalCost AS TotalCost,
ods.Status AS Status 
from ((orders o join customerdetails c on(o.CustomerID = c.CustomerID)) 
left join orderdeliverystatus ods on(o.OrderID = ods.OrderID));