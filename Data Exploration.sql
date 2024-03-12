#BUDGET DATA
-- Create a new table to store the unioned data
CREATE TABLE budgetUnioned (
    Date date  NOT NULL ,
    Amount double(8,2)  NOT NULL ,
    Description varchar(255)  NOT NULL ,
    Category varchar(20) NOT NULL,
    FOREIGN KEY (Category) REFERENCES expense.segment (Category)
);
 
 -- altering the budgetunioned table's constraint - i didnt think its necesarry
 ALTER TABLE budgetUnioned DROP FOREIGN KEY budgetunioned_ibfk_1;
 
 
 -- Insert unioned data into the budgetUnioned table
INSERT INTO budgetUnioned (Date, Amount, Description, Category)
SELECT 
    Date, Amount, Description, Category
FROM 
		-- Unioning all Budget Data from the different yearly tables for data exploration 
			(SELECT Date, Amount, Description, Catogory Category
			FROM 
				(SELECT Date, Amount, Description, Catogory FROM budget.budget2020
				UNION all
				SELECT Date, Amount, Description, Catogory FROM budget.budget2021
				UNION ALL
				SELECT Date, Amount, Description, Catogory FROM budget.budget2022
				UNION ALL
				SELECT Date, Amount, Description, Catogory FROM budget.budget2023
				UNION ALL
				SELECT Date, Amount, Description, Catogory FROM budget.budget2024) AS bu) AS bud
                
;
 


#EXPENSE DATA
-- Create a new table to store the unioned data
drop table expenseUnioned;

-- Create segment table
CREATE TABLE `Segment` (
    `CategoryID` int  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `SegmentID` int  NOT NULL ,
    `Category`varchar(20)  NOT NULL ,
    `Segment` varchar(20)  NOT NULL
);

-- adding index for SegmentID
CREATE INDEX idx_Segment_segmentID ON Segment (Category);

INSERT INTO Segment (Category,Segment, SegmentID)
VALUES 
( 'Church', 'Cost of Living',1),
( 'Food', 'Cost of Living',1),
( 'Home', 'Cost of Living',1),
( 'Insurance', 'Cost of Living',1),
( 'Tax', 'Cost of Living',1),
( 'Transportation', 'Cost of Living',1),
( 'Utilities', 'Cost of Living',1),
( 'Gifts', 'Gifts',2),
( 'Pinas', 'Gifts',2),
( 'Tithes', 'Gifts',2),
( 'Bisyo', 'Recreation',3),
( 'Eat out', 'Recreation',3),
( 'Education', 'Recreation',3),
( 'Entertainment', 'Recreation',3),
( 'Others', 'Recreation',3),
( 'Sports/Health', 'Recreation',3),
( 'Travel', 'Recreation',3),
( 'Crypto', 'Investment',3),
( 'Cushion', 'Investment',3),
( 'Emergency', 'Investment',3),
( 'ETF', 'Investment',3),
( 'Investment', 'Investment',3)
;


CREATE TABLE expenseUnioned (
    Expense_ID int  NOT NULL UNIQUE PRIMARY KEY,
    Date date  NOT NULL ,
    Amount double(8,2)  NOT NULL ,
    Description varchar(255),
    Category varchar(30)  NOT NULL 
);

 
 -- Insert unioned data into the expenseUnioned table
INSERT INTO expenseUnioned (Expense_ID, Date, Amount, Description, Category)
SELECT 
    Expense_ID, Date, Amount, Description, Category
FROM 
		-- Unioning all expense data from the different yearly tables for data exploration 
			(SELECT Expense_ID, Date, Amount, Description, Category
			FROM 
				(SELECT concat(CONVERT(YEAR(DATE), CHAR), CONVERT(Expense_ID,CHAR)) as Expense_ID, Date, Amount, Description, Category FROM expense.expense2020
				UNION all
				SELECT concat(CONVERT(YEAR(DATE), CHAR), CONVERT(Expense_ID,CHAR))  as Expense_ID, Date, Amount, Description, Category FROM expense.expense2021
				UNION ALL
				SELECT concat(CONVERT(YEAR(DATE), CHAR), CONVERT(Expense_ID,CHAR)) as Expense_ID, Date, Amount, Description, Category FROM expense.expense2022
				UNION ALL
				SELECT concat(CONVERT(YEAR(DATE), CHAR), CONVERT(Expense_ID,CHAR)) as Expense_ID, Date, Amount, Description, Category FROM expense.expense2023
				UNION ALL
				SELECT concat(CONVERT(YEAR(DATE), CHAR), CONVERT(Expense_ID,CHAR))  as Expense_ID, Date, Amount, Description, Category FROM expense.expense2024) AS ex) AS exp
;
 
 
 #INCOME DATA
 
 CREATE TABLE Income_Category (
    Category_ID int  NOT NULL PRIMARY KEY UNIQUE auto_increment,
    Category varchar(20)  NOT NULL
);

 

INSERT INTO Income_Category (Category)
VALUES 
('Savings'),
('Paycheck'),
('Bonus'),
('Interest'),
('Others');

CREATE TABLE incomeUnioned (
    Income_ID int  NOT NULL UNIQUE PRIMARY KEY,
    Date date  NOT NULL ,
    Amount double(8,2)  NOT NULL ,
    Description varchar(255),
    Category varchar(30)  NOT NULL 
);


 -- Insert unioned data into the expenseUnioned table
INSERT INTO incomeUnioned (Income_ID, Date, Amount, Description, Category)
SELECT 
    Income_ID, Date, Amount, Description, Category
FROM 
		-- Unioning all income data from the different yearly tables for data exploration 
			(SELECT Income_ID, Date, Amount, Description, Category
			FROM 
				(SELECT concat(YEAR(DATE),Income_ID) as Income_ID, Date, Amount, Description, Category FROM income.income2020
				UNION all
				SELECT concat(YEAR(DATE),Income_ID) as Income_ID, Date, Amount, Description, Category FROM income.income2021
				UNION ALL
				SELECT concat(YEAR(DATE),Income_ID) as Income_ID, Date, Amount, Description, Category FROM income.income2022
				UNION ALL
				SELECT concat(YEAR(DATE),Income_ID) as Income_ID, Date, Amount, Description, Category FROM income.income2023
				UNION ALL
				SELECT concat(YEAR(DATE),Income_ID)  as Income_ID, Date, Amount, Description, Category FROM income.income2024) AS inc) AS inco
;
 