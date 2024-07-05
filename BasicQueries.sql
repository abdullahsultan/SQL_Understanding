CREATE DATABASE IF NOT EXISTS SALES;

USE SALES;

CREATE TABLE Customers(
			customer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
            first_name VARCHAR(225),
            last_name VARCHAR(225),
            email_address VARCHAR(225),
            number_of_complaints INT
);

SELECT * FROM Customers;

DROP TABLE Customers;