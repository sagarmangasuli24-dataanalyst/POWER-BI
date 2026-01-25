
--# 1.SUMMARY DASHBOARD

SELECT *  FROM Bank_Loan;


--1. Total Loan Applications

SELECT COUNT(ID) AS Total_Loan_Applications;

SELECT COUNT(ID) AS MTD_Total_Loan_Applications FROM Bank_Loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;
-- Previous Month Loan Applications
SELECT 
    COUNT(ID) AS PMTD_Loan_Applications
FROM dbo.Bank_Loan
WHERE MONTH(issue_date) = 11 
    AND YEAR(issue_date) = 2021;


-- MoM Change (December vs November)

SELECT 
    SUM(CASE WHEN MONTH(issue_date) = 12 THEN 1 ELSE 0 END) AS Current_Count,
    SUM(CASE WHEN MONTH(issue_date) = 11 THEN 1 ELSE 0 END) AS Previous_Count,
    (SUM(CASE WHEN MONTH(issue_date) = 12 THEN 1 ELSE 0 END) - 
     SUM(CASE WHEN MONTH(issue_date) = 11 THEN 1 ELSE 0 END)) AS MoM_Change,
    CASE 
        WHEN SUM(CASE WHEN MONTH(issue_date) = 11 THEN 1 ELSE 0 END) = 0 THEN 0
        ELSE ROUND(
            (CAST(SUM(CASE WHEN MONTH(issue_date) = 12 THEN 1 ELSE 0 END) AS FLOAT) - 
             SUM(CASE WHEN MONTH(issue_date) = 11 THEN 1 ELSE 0 END)) / 
            SUM(CASE WHEN MONTH(issue_date) = 11 THEN 1 ELSE 0 END) * 100, 2)
    END AS MoM_Change_Percentage
FROM dbo.Bank_Loan
WHERE YEAR(issue_date) = 2021 
    AND MONTH(issue_date) IN (11, 12);


--2. Total Funded Amount

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM Bank_Loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM Bank_Loan
WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount,
       SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM Bank_Loan
WHERE Month(issue_date)=12 AND Month(issue_date)=11
      AND YEAR(issue_date)=2021


--3. Total Amount Received

SELECT SUM(total_payment) AS Total_Amount_Received 
FROM Bank_Loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;


--4. Average Interest Rate

SELECT ROUND(AVG(int_rate),4)*100 AS Average_interest_rate
FROM Bank_Loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

--5. AVG_DEBT-TO-INCOME RATIO

SELECT ROUND(AVG(dti),4) *100 AS Average_dti
FROM Bank_Loan;

--6.GOOD Loans AND BAD Loans
--6.1 Good Loan Percentage
SELECT 
     (COUNT(CASE WHEN loan_status='Fully Paid' OR loan_status='Current' THEN ID END) *100.0)
     /
     COUNT(ID) AS Good_loan_pct,
     (COUNT(CASE WHEN loan_status='Charged Off' THEN ID END) *100.0)
     /
     COUNT(ID) AS Bad_loan_pct
FROM Bank_Loan;

--6.2 Good Loan Applications

SELECT COUNT(ID) AS Good_loan_applications
FROM Bank_Loan
WHERE loan_status IN('Fully Paid','Current');

--Bad Loan Applications

SELECT COUNT(ID) AS Bad_loan_applications
FROM Bank_Loan
WHERE loan_status='Charged Off';

--6.3 Good Loan Funded Amount

SELECT SUM(loan_amount) AS Good_loan_funded_amount
FROM Bank_Loan
WHERE loan_status IN('Fully Paid','Current');

--Bad Loan Funded Amount

SELECT SUM(loan_amount) AS Bad_loan_funded_amount
FROM Bank_Loan
WHERE loan_status='Charged Off';

--6.4 Good Loan Total_amount received

SELECT SUM(total_payment) AS Good_loan_total_amount
FROM Bank_Loan
WHERE loan_status IN('Fully Paid','Current');

--Bad Loan Total amount received
SELECT SUM(total_payment) AS Bad_loan_total_amount
FROM Bank_Loan
WHERE loan_status ='Charged Off';

--7. Loan Status Grid View

SELECT 
     loan_status,
     COUNT(ID) AS Total_Applications,
     SUM(total_payment) AS Total_Amount_Received,
     SUM(loan_amount) AS Total_Funded_Amount,
     AVG(int_rate * 100) AS Interest_Rate,
     AVG(dti) AS DTI
FROM Bank_Loan
GROUP BY loan_status;


SELECT 
     loan_status,
     SUM(total_payment) AS MTD_Total_Amount_Received,
     SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM Bank_Loan
WHERE MONTH(issue_date)=12
GROUP BY loan_status;


# 2. OVERVIEW DASHBOARD 

--1. Monthly Trend Over Issue Date

SELECT 
    MONTH(issue_date)AS Month_Number,
    DATENAME(MONTH,issue_date)AS Month_Name,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM Bank_Loan 
GROUP BY MONTH(issue_date),DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date);

---2 Regional Analysis by State
SELECT 
    address_state,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM Bank_Loan 
GROUP BY address_state
ORDER BY Total_Funded_Amount DESC;

--3 Loan Term Analysis

SELECT 
    term,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM Bank_Loan 
GROUP BY term
ORDER BY term;

--4 Employee Length Analysis

SELECT 
    emp_length,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM Bank_Loan 
GROUP BY emp_length
ORDER BY emp_length;

--5 Loan Purpose Breakdown

SELECT 
    purpose,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM Bank_Loan 
GROUP BY purpose
ORDER BY COUNT(ID) DESC;

--6 Home Ownership Analysis

SELECT 
    home_ownership,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM Bank_Loan 
GROUP BY home_ownership
ORDER BY COUNT(ID) DESC;






