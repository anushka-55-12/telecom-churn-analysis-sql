CREATE DATABASE telecom_churn;
USE telecom_churn;
CREATE TABLE customers (
    customerID VARCHAR(50),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(50),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges FLOAT,
    TotalCharges VARCHAR(50),  -- keep as VARCHAR for now
    Churn VARCHAR(10)
);
SET SQL_SAFE_UPDATES = 0;
USE telecom_churn;
SELECT COUNT(*)
FROM customers
WHERE TotalCharges = '';
ALTER TABLE customers
MODIFY TotalCharges FLOAT;
DESCRIBE customers;
SELECT
MIN(tenure),MAX(tenure),
MIN(MonthlyCharges),MAX(MonthlyCharges),
MIN(TotalCharges),MAX(TotalCharges)
FROM customers;
SELECT COUNT(*) AS total_customers
FROM customers;
SELECT Churn, COUNT(*) AS total
FROM customers
GROUP BY Churn;
SELECT 
ROUND(
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 
2
) AS churn_rate_percentage
FROM customers;
SELECT gender, Churn, COUNT(*) AS total
FROM customers
GROUP BY gender, Churn;
SELECT SeniorCitizen, Churn, COUNT(*) AS total
FROM customers
GROUP BY SeniorCitizen, Churn;
SELECT Contract, Churn, COUNT(*) AS total
FROM customers
GROUP BY Contract, Churn;
SELECT 
Contract,
COUNT(*) AS total_customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM customers
GROUP BY Contract;
SELECT 
PaymentMethod,
COUNT(*) AS total,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM customers
GROUP BY PaymentMethod;
SELECT 
Churn,
AVG(MonthlyCharges) AS avg_monthly
FROM customers
GROUP BY Churn;
SELECT 
InternetService,
COUNT(*) AS total,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM customers
GROUP BY InternetService;
SELECT 
TechSupport,
COUNT(*) AS total,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM customers
GROUP BY TechSupport;
SELECT 
Churn,
ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charges
FROM customers
GROUP BY Churn;
SELECT 
ROUND(SUM(MonthlyCharges),2) AS monthly_revenue_lost
FROM customers
WHERE Churn = 'Yes';
SELECT 
ROUND(SUM(MonthlyCharges),2) AS total_monthly_revenue
FROM customers;
SELECT 
ROUND(
    SUM(CASE WHEN Churn='Yes' THEN MonthlyCharges ELSE 0 END) * 100.0
    / SUM(MonthlyCharges),
2) AS revenue_loss_percentage
FROM customers;
SELECT 
CASE 
    WHEN MonthlyCharges > 80 THEN 'High Value'
    WHEN MonthlyCharges BETWEEN 50 AND 80 THEN 'Medium Value'
    ELSE 'Low Value'
END AS customer_segment,
COUNT(*) AS total,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM customers
GROUP BY customer_segment;
SELECT 
CASE 
    WHEN tenure < 12 THEN '0-1 Year'
    WHEN tenure < 24 THEN '1-2 Years'
    WHEN tenure < 48 THEN '2-4 Years'
    ELSE '4+ Years'
END AS tenure_group,
COUNT(*) AS total_customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM customers
GROUP BY tenure_group
ORDER BY tenure_group;
SELECT 
Churn,
ROUND(AVG(tenure),2) AS avg_tenure
FROM customers
GROUP BY Churn;
SELECT 
COUNT(*) AS early_churn
FROM customers
WHERE tenure < 6 AND Churn='Yes';
SELECT 
Contract,
PaymentMethod,
COUNT(*) AS total,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS churn_rate
FROM customers
GROUP BY Contract, PaymentMethod
ORDER BY churn_rate DESC;
SELECT 
CASE 
    WHEN tenure < 12 THEN '0-1 Year'
    WHEN tenure < 24 THEN '1-2 Years'
    ELSE '2+ Years'
END AS tenure_group,
Contract,
COUNT(*) AS total,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM customers
GROUP BY tenure_group, Contract;
SELECT 
Contract,
CASE 
    WHEN MonthlyCharges > 80 THEN 'High'
    WHEN MonthlyCharges BETWEEN 50 AND 80 THEN 'Medium'
    ELSE 'Low'
END AS charge_group,
COUNT(*) AS total,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM customers
GROUP BY Contract, charge_group;
SELECT 
InternetService,
TechSupport,
COUNT(*) AS total,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM customers
GROUP BY InternetService, TechSupport;
