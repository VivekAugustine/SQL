use fastkart;

-- List Top 3 products based on QuantityAvailable. (productid, productname, QuantityAvailable).

select ProductId, ProductName, QuantityAvailable from products 
order by QuantityAvailable desc
limit 3;

-- Display EmailId of those customers who have done more than ten purchases. (EmailId,Total_Transactions).

select ph.EmailId,pd.ProductName,count(ph.QuantityPurchased) as Total_Purchases  
from purchasedetails ph join products pd 
on ph.ProductId = pd.ProductId
group by ph.EmailId
having count(ph.QuantityPurchased)>10;

-- List the Total QuantityAvailable category wise in descending order. (Name of the category,QuantityAvailable)

select c.CategoryName,count(pd.QuantityAvailable) as Total_Quantity_Available
from categories c join products pd
on c.CategoryId = pd.CategoryId
group by c.CategoryName
order by count(pd.QuantityAvailable) desc;

-- Display ProductId, ProductName, CategoryName, Total_Purchased_Quantity for the product which has been sold maximum in terms of quantity?

select pd.ProductId, pd.ProductName, c.CategoryName, max(ph.QuantityPurchased) as Max_Quantity_Purchased
from purchasedetails ph join products pd
on ph.ProductId = pd.ProductId
join categories c
on pd.CategoryId = c.CategoryId
order by max(ph.QuantityPurchased);

-- Display the number of male and female customers in fastkart.

select Gender, 
count(*) as total_cnt
from users
group by Gender;

-- Display ProductId, ProductName, Price and Item_Classes of all the products 
select pd.ProductId,pd.ProductName,pd.Price,
CASE pd.ProductId
WHEN Price <= 2000 then 'Affordable'
WHEN Price >= 2000 and Price <= 50000 then 'High_End_Stuff'
WHEN Price > 50000 then 'Luxury'
end as Item_Classes from 
products pd ;



-- Write a query to display ProductId, ProductName, CategoryName, Old_Price(price) andNew_Price

SELECT ProductId,ProductName,categories.CategoryName as CategoryName, Price AS Old_Price,
       CASE categories.CategoryName
            WHEN 'Motors' THEN Price - 3000
            WHEN 'Electronics' THEN Price + 50
            WHEN 'Fashion' THEN Price + 150
            ELSE Price
       END AS New_Price
FROM products pd INNER JOIN categories
on pd.CategoryId = categories.CategoryId;


-- Display the percentage of females present among all Users. (Round up to 2 decimal places)Add "%" sign while displaying the percentage

select concat(round(((40 / 85) * 100 ),2), '%') as Female_Precentage;

-- Display the average balance for both card types for those records only where CVVNumber >333 and NameOnCard ends with the alphabet "e"

select cd.CardType,avg(cd.Balance),cd.NameOnCard,cd.CVVNumber from carddetails cd
where cd.NameOnCard like '%e'
group by cd.CardType
having cd.CVVNumber>333;

-- What is the 2nd most valuable item available which does notbelong to the "Motor" category.
-- Value of an item = Price * QuantityAvailable. Display ProductName, CategoryName, value.

select pd.ProductName, c.CategoryName,(pd.Price*pd.QuantityAvailable) as Value
from products pd join categories c
on pd.CategoryId = c.CategoryId
group by c.CategoryName
order by Value desc;
