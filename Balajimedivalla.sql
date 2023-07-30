--Answers--

VARIABLE MYCONSTANT VARCHAR2(10);
EXEC :MYCONSTANT:='[^0-9.]';

SELECT EXTRACT(YEAR FROM "DATE") AS YEAR,
MAX(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MYCONSTANT,'') AS NUMBER)) AS HighestDebiteddAmount
FROM BANK_TRANSACTION
WHERE WITHDRAWAL_AMT IS NOT NULL
GROUP BY EXTRACT(YEAR FROM "DATE") ORDER BY EXTRACT(YEAR FROM "DATE") ASC;

SELECT EXTRACT(YEAR FROM "DATE") AS YEAR,
MIN(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MYCONSTANT,'') AS NUMBER)) AS LowestDebitedAmount
FROM BANK_TRANSACTION
WHERE WITHDRAWAL_AMT IS NOT NULL
GROUP BY EXTRACT(YEAR FROM "DATE") ORDER BY EXTRACT(YEAR FROM "DATE") ASC;


SELECT Year,FifthHighestAmount
FROM(
    SELECT EXTRACT(YEAR FROM "DATE")AS Year,
    CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MYCONSTANT,'') AS NUMBER) AS FifthHighestAmount,
    DENSE_RANK() OVER (PARTITION BY EXTRACT(YEAR FROM "DATE") ORDER BY
    CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MYCONSTANT,'') AS NUMBER) DESC) AS R
    FROM BANK_TRANSACTION
    WHERE CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MYCONSTANT,'') AS NUMBER) IS NOT NULL
    )
WHERE R=5;

SELECT COUNT(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MYCONSTANT,'') AS NUMBER)) AS With_drawal_Count
FROM BANK_TRANSACTION
WHERE "DATE" BETWEEN TO_DATE('05-05-2018','DD-MM-YYYY') AND TO_DATE('07-03-2019','DD-MM-YYYY');

SELECT DISTINCT EXTRACT(YEAR FROM "DATE")AS Year,
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MYCONSTANT,'') AS NUMBER) AS Largest_Withdrawal
FROM BANK_TRANSACTION
WHERE EXTRACT(YEAR FROM "DATE")=2018 AND
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,'[^0-9.]','') AS NUMBER) IS NOT NULL
ORDER BY CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MYCONSTANT,'') AS NUMBER) DESC
FETCH FIRST 5 ROWS ONLY;

