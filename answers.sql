Qn1:
SELECT 
    OrderID,
    CustomerName,
    TRIM(product) AS Product
FROM (
    SELECT 
        OrderID, 
        CustomerName,
        JSON_TABLE(
            CONCAT('[', REPLACE(Products, ',', '","'), ']'),
            '$[*]' COLUMNS(product VARCHAR(255) PATH '$')
        ) AS jt
    FROM ProductDetail
) AS transformed;

Qn2:
  A.Create tables
  
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

CREATE TABLE OrderDetails (
  OrderID INT,
  Product VARCHAR(100),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

  B.Populate the tables from the original data

-- Insert unique orders and customers
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OriginalOrderDetails;

-- Insert order details
INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OriginalOrderDetails;



