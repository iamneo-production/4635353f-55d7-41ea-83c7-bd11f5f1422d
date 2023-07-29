PL_SQL_BANKING_INTERNSHIP_ORACLE_WORKSPACE
/* PL_SQL_BANKING_INTERNSHIP_WORKSPACE*/

/*(1) RETRIEVING ALL THE DATA FROM THE TABLE BANK_TRANSACTION*/
SELECT * FROM BANK_TRANSACTION;

-- /*(2) WRITE A SQL QUERY TO FIND THE HIGHEST AMOUNT DEBITED FROM THE BANK EACH YEAR....?*/

SELECT EXTRACT (YEAR FROM "DATE") AS YEAR,
MAX(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER)) AS HIGHEST_DEBITED_AMOUNT
FROM BANK_TRANSACTION
WHERE WITHDRAWAL_AMT IS NOT NULL
GROUP BY EXTRACT (YEAR FROM "DATE");

/*(3) WRITE A SQL QUERY TO FIND THE LOWEST AMOUNT DEBITED FROM THE BANK EACH YEAR?*/

SELECT EXTRACT (YEAR FROM "DATE") AS YEAR,
MIN(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER)) AS LOWEST_DEBITED_AMOUNT
FROM BANK_TRANSACTION
WHERE WITHDRAWAL_AMT IS NOT NULL
GROUP BY EXTRACT (YEAR FROM "DATE");

/*(4) WRITE A SQL QUERY TO FIND THE 5TH HIGHEST WITHDRAWAL AMOUNT AT EACH YEAR?*/

SELECT YEAR, FIFTH_HIGHEST_AMT FROM (
SELECT EXTRACT (YEAR FROM "DATE") AS YEAR,
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER) AS FIFTH_HIGHEST_AMT,
DENSE_RANK() OVER(PARTITION BY EXTRACT (YEAR FROM "DATE") ORDER BY CAST (REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]','')
AS NUMBER) DESC) AS R FROM BANK_TRANSACTION
WHERE CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER) IS NOT NULL)
WHERE R = 5;

/*(5) WRITE A SQL QUERY TO COUNT THE WITHDRAWAL TRANSACTION BETWEEN MAY5, 2018 AND MARCH 7, 2019?*/

SELECT COUNT (CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER)) WITH_DRAWAL_COUNT
FROM BANK_TRANSACTION
WHERE "DATE" BETWEEN TO_DATE('05-05-2018', 'DD-MM-YYYY') AND TO_DATE('07-03-2019', 'DD-MM-YYYY');

/*(6) WRITE A SQL QUERY TO FIND THE FIVE LARGEST WITHDRAWAL TRANSACTION ARE OCCURED IN YEAR 18?*/

SELECT DISTINCT EXTRACT (YEAR FROM "DATE") AS YEAR,
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER) AS LARGEST_WITH_DRAWAL FROM BANK_TRANSACTION
WHERE EXTRACT(YEAR FROM "DATE") = 2018 AND CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER) IS NOT NULL
ORDER BY CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER)
DESC FETCH FIRST 5 ROWS ONLY;
