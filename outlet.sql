DROP database outlet_management;
Create database Outlet_Management;
use Outlet_Management;

-- Create the stakeholder table
CREATE TABLE stakeholder (
    stakeholder_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    position VARCHAR(100) NOT NULL,
    entry_date DATE,
    exit_date DATE
);

-- Sample Data 
INSERT INTO stakeholder (stakeholder_id, name, email, position, entry_date, exit_date) VALUES
(1,'Rahul Jain', 'jain.rahul@iitgn.ac.in', 'Survey_head', '2023-05-04', NULL),
(2,'Sparsh Singh', 'singh.sparsh@iitgn.ac.in', 'Cleaning_incharge', '2023-01-15', NULL),
(3,'Hrishav Gupta', 'gupta.hrishav@iitgn.ac.in', 'Maintanence_head', '2023-03-12', NULL),
(4,'Rounak Mehta', 'mehta.rounak@iitgn.ac.in', 'Logistics_incharge', '2023-05-11', NULL),
(5,'Ayush Singh', 'singh.ayush@iitgn.ac.in', 'Survey_head', '2023-03-15', NULL),
(6,'Ayush Kumar', 'kumar.ayush@iitgn.ac.in', 'Rent_incharge', '2023-04-23', NULL),
(7,'Darsh Rungta', 'rungta.darsh@iitgn.ac.in', 'Logistics_incharge', '2023-01-11', NULL),
(8,'Yash Kumar', 'kumar.yash@iitgn.ac.in', 'Maintanence_head', '2023-05-18', NULL),
(9,'Nakul Lal', 'lal.nakul@iitgn.ac.in', 'Cleaning_incharge', '2023-08-01', NULL),
(10,'Himanshu Yadav', 'yadav.himanshu@iitgn.ac.in', 'Survey_head', '2023-09-01', NULL),
(11,'Aman Verma', 'verma.aman@iitgn.ac.in', 'Cleaning_incharge', '2023-07-20', NULL),
(12,'Sneha Sharma', 'sharma.sneha@iitgn.ac.in', 'Logistics_incharge', '2023-02-10', NULL),
(13,'Akash Patel', 'patel.akash@iitgn.ac.in', 'Maintanence_head', '2023-04-05', NULL),
(14,'Pooja Gupta', 'gupta.pooja@iitgn.ac.in', 'Survey_head', '2023-06-15', NULL),
(15,'Rajesh Kumar', 'kumar.rajesh@iitgn.ac.in', 'Rent_incharge', '2023-08-25', NULL);


-- Add a new column for the password
ALTER TABLE stakeholder ADD COLUMN password VARCHAR(20);

-- Update existing records with the first name as the password
UPDATE stakeholder SET password = SUBSTRING_INDEX(name, ' ', 1);

select * from stakeholder;

-- Create the Outlet table
CREATE TABLE Outlet (
    Outlet_ID INT AUTO_INCREMENT PRIMARY KEY,
    Stakeholder_ID  INT,
    Outlet_name VARCHAR(50) NOT NULL,
    Location_name VARCHAR(50) NOT NULL,
    Contact_No BIGINT CHECK (Contact_No >= 1000000000 AND Contact_No < 10000000000),
    timings VARCHAR(50),
    Ratings FLOAT,
    FOREIGN KEY (stakeholder_id) REFERENCES stakeholder(stakeholder_id) ON DELETE CASCADE
);

-- Sample Data with Outlet_ID included
INSERT INTO Outlet (Outlet_ID, Stakeholder_ID, Outlet_name, Location_name, Contact_No, timings, Ratings) VALUES
(1, 1, 'Atul Bakery', 'Location 1', 1234567890, '9:00 AM - 6:00 PM', 4.5),
(2, 2, 'Dawat Food', 'Location 2', 2345678901, '10:00 AM - 7:00 PM', 4.2),
(3, 3, 'Mahaveer Food', 'Location 3', 3456789012, '9:30 AM - 6:30 PM', 4.0),
(4, 4, 'Tea Post', 'Location 4', 4567890123, '9:00 AM - 5:00 PM', 4.8),
(5, 5, 'VS Fast Food', 'Location 5', 5678901234, '8:00 AM - 4:00 PM', 4.6),
(6, 6, 'Go Insta', 'Location 6', 6789012345, '10:30 AM - 7:30 PM', 4.3),
(7, 7, 'Pooja Stationery', 'Location 7', 7890123456, '8:30 AM - 5:30 PM', 4.1),
(8, 8, 'Mondego', 'Location 8', 8901234567, '9:00 AM - 6:00 PM', 4.7),
(9, 9, '2 degree Cafe', 'Location 9', 9012345678, '9:00 AM - 5:30 PM', 4.4),
(10, 10, 'Mini 2 degree', 'Location 10', 1234567891, '10:00 AM - 8:00 PM', 4.9),
(11, 1, 'Samyak Shop', 'Location 11', 1234567890, '9:00 AM - 6:00 PM', 4.3),
(12, 2, 'Amul Shop', 'Location 12', 2345678901, '10:00 AM - 7:00 PM', 4.1),
(13, 3, 'Krupa Generals', 'Location 13', 3456789012, '9:30 AM - 6:30 PM', 4.5),
(14, 4, 'Just Chill Cafe', 'Location 14', 4567890123, '9:00 AM - 5:00 PM', 4.2),
(15, 5, 'JK Grocery', 'Location 15', 5678901234, '8:00 AM - 4:00 PM', 4.7);
select * from Outlet;

-- ALTER TABLE Outlet ADD COLUMN Country_Code JSON;
-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE Outlet SET Country_Code = JSON_EXTRACT(JSON_OBJECT('Country Code', '+91'), '$."Country Code"');


-- DELETE FROM Outlet WHERE Outlet_ID = 10;


-- Create the Rent payment table
CREATE TABLE Rent_payment (
    Payment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Transaction_ID INT UNIQUE,
    Outlet_ID INT,
    Mode_of_payment VARCHAR(50),
    Paid_amount DECIMAL(10, 2),
    Rent_from_date DATE,
    Rent_to_date DATE,
    Due_amount DECIMAL(10, 2),
    FOREIGN KEY (Outlet_ID) REFERENCES Outlet(Outlet_ID) ON DELETE CASCADE
);

-- Sample Data with Payment_ID included
INSERT INTO Rent_payment (Payment_ID, Transaction_ID, Outlet_ID, Mode_of_payment, Paid_amount, Rent_from_date, Rent_to_date, Due_amount) VALUES
(1, 1, 1, 'Cash', 8000.00, '2023-09-01', '2023-09-30', 0.00),
(2, 2, 2, 'Credit Card', 6200.00, '2023-09-01', '2023-09-30', 1200.00),
(3, 3, 3, 'Debit Card', 9500.00, '2023-07-01', '2023-07-31', 0.00),
(4, 4, 4, 'Bank Transfer', 7000.00, '2023-07-01', '2023-07-31', 0.00),
(5, 5, 5, 'Cash', 7200.00, '2023-08-01', '2023-08-31', 0.00),
(6, 6, 6, 'Credit Card', 4500.00, '2023-10-01', '2023-10-31', 800.00),
(7, 7, 7, 'Debit Card', 5800.00, '2023-11-01', '2023-11-30', 0.00),
(8, 8, 8, 'Bank Transfer', 6500.00, '2023-12-01', '2023-12-31', 0.00),
(9, 9, 9, 'Cash', 2300.00, '2023-08-01', '2023-08-31', 0.00),
(10, 10, 10, 'Credit Card', 2400.00, '2023-07-01', '2023-07-31', 2200.00),
(11, 11, 11, 'Cash', 8000.00, '2023-09-01', '2023-09-30', 0.00),
(12, 12, 12, 'Credit Card', 6200.00, '2023-09-01', '2023-09-30', 1200.00),
(13, 13, 13, 'Debit Card', 9500.00, '2023-07-01', '2023-07-31', 0.00),
(14, 14, 14, 'Bank Transfer', 7000.00, '2023-07-01', '2023-07-31', 0.00),
(15, 15, 15, 'Cash', 7200.00, '2023-08-01', '2023-08-31', 0.00);

select * from Rent_payment;

-- Create the Survey table
CREATE TABLE Survey (
    Survey_ID INT AUTO_INCREMENT PRIMARY KEY,
    Stakeholder_ID INT,
    Outlet_ID INT,
    Date_of_survey DATE,
    Description TEXT,
    Warning_issued VARCHAR(20),
    Penalty_amount DECIMAL(10, 2),
    FOREIGN KEY (Stakeholder_ID) REFERENCES Stakeholder(stakeholder_id),
    FOREIGN KEY (Outlet_ID) REFERENCES Outlet(Outlet_ID)  ON DELETE CASCADE
);

-- Sample Data with primary keys included
INSERT INTO Survey (Survey_ID, Stakeholder_ID, Outlet_ID, Date_of_survey, Description, Warning_issued, Penalty_amount) VALUES
(1, 1, 1, '2023-01-01', 'Cleanliness issue observed in the restroom area.', 'Yes', 150.00),
(2, 2, 2, '2023-01-05', 'Kitchen equipment needs maintenance.', 'Yes', 200.00),
(3, 3, 3, '2023-01-10', 'Customer complaints regarding slow service.', 'Yes', 100.00),
(4, 4, 4, '2023-01-15', 'Everything Working efficiently.', 'No', NULL),
(5, 5, 5, '2023-01-20', 'Good conditions.', 'No', NULL),
(6, 6, 6, '2023-01-25', 'Unsanitary conditions observed in the dining area.', 'No', 80.00),
(7, 7, 7, '2023-02-01', 'Safety hazards identified in the outdoor seating area.', 'Yes', 250.00),
(8, 8, 8, '2023-02-05', 'Inventory management issues reported.', 'Yes', 150.00),
(9, 9, 9, '2023-02-10', 'Well-maintained in all scope.', 'No', NULL),
(10, 10, 10, '2023-02-15', 'Hygiene standards not met in the food preparation area.', 'Yes', 200.00),
(11, 11, 11, '2023-01-01', 'Cleanliness issue observed in the restroom area.', 'Yes', 150.00),
(12, 12, 12, '2023-01-05', 'Kitchen equipment needs maintenance.', 'Yes', 200.00),
(13, 13, 13, '2023-01-10', 'Customer complaints regarding slow service.', 'Yes', 100.00),
(14, 14, 14, '2023-01-15', 'Everything Working efficiently.', 'No', NULL),
(15, 15, 15, '2023-01-20', 'Good conditions.', 'No', NULL);

select * from Survey;

-- Create the Customer_feedback table
CREATE TABLE Customer_feedback (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Outlet_ID INT,
    Customer_email VARCHAR(30),
    Customer_rating FLOAT,
    FOREIGN KEY (Outlet_ID) REFERENCES Outlet(Outlet_ID) ON DELETE CASCADE
);

-- Sample Data with primary keys included
INSERT INTO Customer_feedback (Customer_ID, Outlet_ID, Customer_email, Customer_rating) VALUES
(1, 1, 'customer1@gmail.com', 4.5),
(2, 2, NULL, 4.2),
(3, 3, 'customer3@gmail.com', 4.8),
(4, 4, NULL, 3.9),
(5, 5, 'customer5@gmail.com', 4.1),
(6, 6, NULL, 4.6),
(7, 7, 'customer7@gmail.com', 3.7),
(8, 8, NULL, 4.9),
(9, 9, 'customer9@gmail.com', 4.3),
(10, 10, NULL, 4.7),
(11, 1, 'customer11@gmail.com', 4.5),
(12, 2, NULL, 4.2),
(13, 3, 'customer13@gmail.com', 4.8),
(14, 4, NULL, 3.9),
(15, 5, 'customer15@gmail.com', 4.1);

select * from Customer_feedback;

-- Create the Inventory table
CREATE TABLE Inventory (
    Item_ID INT AUTO_INCREMENT PRIMARY KEY,
    Outlet_ID INT,
    Item_name VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2),
    FOREIGN KEY (Outlet_ID) REFERENCES Outlet(Outlet_ID) ON DELETE CASCADE
);

-- Sample Data with primary keys included
INSERT INTO Inventory (Item_ID, Outlet_ID, Item_name, Price) VALUES
(1, 1, 'Item 1', 400.00),
(2, 2, 'Item 2', 200.00),
(3, 3, 'Item 3', 120.00),
(4, 4, 'Item 4', 100.00),
(5, 5, 'Item 5', 230.00),
(6, 6, 'Item 6', 50.00),
(7, 7, 'Item 7', 20.00),
(8, 8, 'Item 8', 30.00),
(9, 9, 'Item 9', 45.00),
(10, 10, 'Item 10', 70.00),
(11, 11, 'Item 11', 400.00),
(12, 12, 'Item 12', 200.00),
(13, 13, 'Item 13', 120.00),
(14, 14, 'Item 14', 100.00),
(15, 15, 'Item 15', 230.00);

-- View the inserted data
SELECT * FROM Inventory;

-- Create the Employees table
CREATE TABLE Employees (
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    Outlet_ID INT,
    Employee_name VARCHAR(20) NOT NULL,
    Role VARCHAR(20),
    Mobile_number BIGINT CHECK (Mobile_number >= 1000000000 AND Mobile_number < 10000000000),
    Shift_time VARCHAR(30),
    FOREIGN KEY (Outlet_ID) REFERENCES Outlet(Outlet_ID) ON DELETE CASCADE
);

-- Sample Data with primary keys included
INSERT INTO Employees (Employee_ID, Outlet_ID, Employee_name, Role, Mobile_number, Shift_time) VALUES
(1, 1, 'Kartik Gupta', 'Manager', 9876543210, 'Night shift'),
(2, 1, 'Tushar Mishra', 'Cashier', 8765432109, '10:00 AM - 6:00 PM'),
(3, 2, 'Kedhar Jadhav', 'Chef', 7654321098, '12:00 PM - 8:00 PM'),
(4, 2, 'Manish Pandey', 'Security Guard', 6543210987, 'Night Shift'),
(5, 3, 'Pankaj Tripathi', 'Delivery boy', 5432109876, '8:00 AM - 4:00 PM'),
(6, 3, 'Abhishek Kumar', 'Stock incharge', 4321098765, '9:00 AM - 5:00 PM'),
(7, 4, 'Ashish Mehta', 'Waiter', 3210987654, '4:00 PM - 12:00 AM'),
(8, 4, 'Rishikesh Yadav', 'Chef', 2109876543, 'Night shift'),
(9, 5, 'Siddharth Kishore', 'Cashier', 1098765432, '6:00 AM - 2:00 PM'),
(10, 5, 'Mohit Ranjan', 'Delivery boy', 1234567890, '2:00 PM - 10:00 PM');

-- View the inserted data
SELECT * FROM Employees;

-- Create the Contract table
CREATE TABLE Contract (
    Contract_ID INT AUTO_INCREMENT PRIMARY KEY,
    Outlet_ID INT,
    Document_number INT NOT NULL,
    Start_date DATE,
    End_date DATE,
    Contract_status VARCHAR(50),
    FOREIGN KEY (Outlet_ID) REFERENCES Outlet(Outlet_ID) ON DELETE CASCADE
);

-- Sample Data with primary keys included
INSERT INTO Contract (Contract_ID, Outlet_ID, Document_number, Start_date, End_date, Contract_status) VALUES
(1, 1, 1, '2023-01-01', '2023-12-31', 'Active'),
(2, 2, 2, '2023-02-01', '2023-11-30', 'Active'),
(3, 3, 3, '2023-03-01', '2023-10-31', 'Active'),
(4, 4, 4, '2023-04-01', '2023-09-30', 'Active'),
(5, 5, 5, '2023-05-01', '2023-08-31', 'Active'),
(6, 6, 6, '2023-06-01', '2023-07-31', 'Active'),
(7, 7, 7, '2023-07-01', '2023-06-30', 'Inactive'),
(8, 8, 8, '2023-08-01', '2023-05-31', 'Inactive'),
(9, 9, 9, '2023-09-01', '2023-04-30', 'Inactive'),
(10, 10, 10, '2023-10-01', '2023-03-31', 'Inactive'),
(11, 11, 11, '2023-01-01', '2023-12-31', 'Active'),
(12, 12, 12, '2023-02-01', '2023-11-30', 'Active'),
(13, 13, 13, '2023-03-01', '2023-10-31', 'Active'),
(14, 14, 14, '2023-04-01', '2023-09-30', 'Active'),
(15, 15, 15, '2023-05-01', '2023-08-31', 'Active');


-- View the inserted data
SELECT * FROM Contract;


-- G1 & G2 storage of an image

CREATE TABLE storing_img (
    id_pic INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    caption VARCHAR(45) NOT NULL,
    imge LONGBLOB DEFAULT NULL,
    PRIMARY KEY (id_pic)
);

INSERT INTO storing_img(caption, imge) VALUES ('ATUL BAKERY', LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ATUL_Bakeery.jpeg'));
INSERT INTO storing_img (caption, imge) VALUES ('DAWAT FOODS', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DAWAT FOODS.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('MAHAVEER HEALTHY FOOD', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MAHAVEER HEALTHY FOOD.jpeg"));
INSERT INTO storing_img (caption, imge) VALUES ('TEA POST', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Tea Post.jpeg"));
INSERT INTO storing_img (caption, imge) VALUES ('VS FAST FOOD', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vs fast food.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('GO INSTA', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Go Insta.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES (' POOJA', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/POOJA.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('MONDEGO', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MONDEGO.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('2 DEGREE', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2DE.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES (' MINI 2 DEGREE', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MIN2DE.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('SAMYAK', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/SAMYAK.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('TFC', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/TFC.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('AMUL', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/AMU.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('KRUPA GENERALS', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/KR.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('JUST CHILL', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/JUST CHILL.jpeg"));
INSERT INTO storing_img(caption, imge) VALUES ('JK GROCERY', LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/JK.jpeg"));

select  * from storing_img ;


CREATE TABLE student_credentials (
  name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  Password VARCHAR(50) NOT NULL,
  CONSTRAINT PK_User PRIMARY KEY (email)
);



INSERT INTO student_credentials (name, email, Password) VALUES
('Krish Raj', 'rajkrish@iitgn.ac.in', 'Krish'),
('Jethalal', 'jethalal@iitgn.ac.in', 'babita');

select * from student_credentials;