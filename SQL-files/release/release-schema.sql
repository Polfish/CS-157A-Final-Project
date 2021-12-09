-- Drop database to create a new one
DROP DATABASE IF EXISTS finance_tracker;

-- Create database
CREATE DATABASE finance_tracker;

-- Use the database
USE finance_tracker;

-- Create tables
CREATE TABLE user (
    user_id INT AUTO_INCREMENT,
    username VARCHAR(128),
    password VARCHAR(128),
    PRIMARY KEY (user_id)
);

CREATE TABLE budget (
    budget_id INT AUTO_INCREMENT,
    user_id INT,
    budget_name VARCHAR(128),
    amount DOUBLE,
    startDate INT,
    endDate INT,
    PRIMARY KEY (budget_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE account (
    account_id INT AUTO_INCREMENT,
    account_name VARCHAR(128),
    user_id INT,
    balance DOUBLE,
    PRIMARY KEY (account_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE category (
    category_id INT AUTO_INCREMENT,
    category_name VARCHAR(128),
    PRIMARY KEY (category_id)
);

CREATE TABLE transaction (
    transaction_id INT AUTO_INCREMENT,
    category_id INT,
    account_id INT,
    date INT,
    notes VARCHAR(128),
    amount DOUBLE,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);

-- Creating user views
-- CREATE VIEW AS MonthlySpendingReport
-- ;

-- CREATE VIEW AS UserBudgetReport
-- ;

-- CREATE VIEW AS NetWorthBudget
-- ;