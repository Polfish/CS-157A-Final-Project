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
((SELECT user_id FROM user WHERE username = 'rainy'), 'Save on water', 3, '2021-12-28', '9999-12-31'),
((SELECT user_id FROM user WHERE username = 'rainy'), 'Paying off Student Loan', 107382, '2021-12-21', '2187-11-21'),
((SELECT user_id FROM user WHERE username = 'bob-ffa'), 'Grocery shopping', 10, '2021-05-01', '2021-05-08'),
((SELECT user_id FROM user WHERE username = 'e'), 'Anything entertainment', 800, '2020-08-01', '2020-08-31'),
((SELECT user_id FROM user WHERE username = 'e'), 'Anything entertainment', 1000, '2020-09-01', '2020-09-30'),
((SELECT user_id FROM user WHERE username = 'bob-ffa'), 'Computer parts', 1000000, '2021-12-08', '2021-12-09');

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
((SELECT category_id FROM category WHERE category_name = 'Entertainment'), 
(SELECT account_id FROM account WHERE account_name = 'Netflix' AND balance = 0), '2021-12-14', 'I want to watch something fun!', 1000),
((SELECT category_id FROM category WHERE category_name = 'Essentials'),
(SELECT account_id FROM account WHERE account_name = 'Bank of America'), '2021-12-25', 'water', 1),
((SELECT category_id FROM category WHERE category_name = 'Essentials'),
(SELECT account_id FROM account WHERE account_name = 'Wells Fargo'), '2021-12-25', 'Movies', 18),
((SELECT category_id FROM category WHERE category_name = 'Debts'), 
(SELECT account_id FROM account WHERE account_name = 'Student Loan'), '2021-12-21', 'Starting to pay of my student loan!', 9187);