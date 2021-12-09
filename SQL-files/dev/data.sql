-- This is example data to test on
-- User table
INSERT INTO user (username, password)
VALUES 
('rainy', 'password'),
('bob-ffa', '02938*$71'),
('e', '93jf9345-');

-- Budget table
INSERT INTO budget (user_id, budget_name, amount, startDate, endDate)
VALUES 
((SELECT user_id FROM user WHERE username = 'rainy'), 'Save on water', 3, 2021128, 99991231),
((SELECT user_id FROM user WHERE username = 'rainy'), 'Paying off Student Loan', 107382, 2021121, 21871121),
((SELECT user_id FROM user WHERE username = 'bob-ffa'), 'Grocery shopping', 10, 20210501, 20210508),
((SELECT user_id FROM user WHERE username = 'e'), 'Anything entertainment', 800, 20200801, 20200831),
((SELECT user_id FROM user WHERE username = 'bob-ffa'), 'Computer parts', 1000000, 2021128, 2021129);

-- Account table
INSERT INTO account (account_name, user_id, balance)
VALUES 
('Bank of America', (SELECT user_id FROM user WHERE username = 'bob-ffa'), 58173.78),
('Netflix', (SELECT user_id FROM user WHERE username = 'bob-ffa'), 0),
('Netflix', (SELECT user_id FROM user WHERE username = 'rainy'), -12.99),
('Wells Fargo', (SELECT user_id FROM user WHERE username = 'e'), 78167342.82),
('Student Loan', (SELECT user_id FROM user WHERE username = 'rainy'), -107382),
('Chase', (SELECT user_id FROM user WHERE username = 'rainy'), 3);

-- Category table
INSERT INTO category (category_name)
VALUES 
('Entertainment'),
('Essentials'),
('Insurance'),
('Savings'),
('Debts');

-- Transaction table
INSERT INTO transaction (category_id, account_id, date, notes, amount)
VALUES 
((SELECT category_id FROM category WHERE category_name = 'Entertainment') 
(SELECT account_id FROM account WHERE account_name = 'Netflix' AND balance = 0), 20190314, 'I want to watch something fun!', 1000),
((SELECT category_id FROM category WHERE category_name = 'Essentials') 
(SELECT account_id FROM account WHERE account_name = 'Bank of America'), 99991231, 'water', 1),
((SELECT category_id FROM category WHERE category_name = 'Debts') 
(SELECT account_id FROM account WHERE account_name = 'Student Loan'), 20211121, 'Starting to pay of my student loan!', 9187);