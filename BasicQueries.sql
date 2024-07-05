CREATE DATABASE IF NOT EXISTS SALES;

USE SALES;

DROP TABLE Sales;
DROP TABLE Customers;
DROP TABLE Items;
DROP TABLE Companies;

CREATE TABLE Sales(
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
    PRIMARY KEY(purchase_number)
);

CREATE TABLE Customers(
	customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),  
    last_name VARCHAR(255),  
    email_address VARCHAR(255),
    number_of_complaints INT DEFAULT 0,
	PRIMARY KEY(customer_id)
);

ALTER TABLE Customers
ADD COLUMN gender ENUM('M','F') AFTER last_name;

INSERT INTO Customers (first_name, last_name, email_address, number_of_complaints) VALUES ('John', 'Lalli', 'john.lalli@mail.com', 0);

CREATE TABLE Items(
	item_code VARCHAR(225),
    item VARCHAR(225),
    unit_price NUMERIC(10,2),
    company_id VARCHAR(225),
    PRIMARY KEY(item_code)
);

CREATE TABLE Companies(
	company_id VARCHAR(225),
    company_name VARCHAR(225),
    headquarters_phone_number INTEGER(12),
    PRIMARY KEY(company_id)
);

SELECT * FROM Customers;

