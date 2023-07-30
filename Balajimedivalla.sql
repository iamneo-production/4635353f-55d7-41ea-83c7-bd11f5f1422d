--Answers--
VARIABLE MY_CON VARCHAR2(10);
EXEC :MY_CON:='[^0-9.]';
--Answer for first query a and output
SELECT EXTRACT(YEAR FROM "DATE") AS YEAR,
MAX(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CON,'') AS NUMBER)) AS HighestDebiteddAmount
FROM BANK_TRANSACTION
WHERE WITHDRAWAL_AMT IS NOT NULL 
GROUP BY EXTRACT(YEAR FROM "DATE") ORDER BY EXTRACT(YEAR FROM "DATE") ASC;

--answer for second qury b and outputt
SELECT EXTRACT (YEAR FROM "DATE") AS YEAR,
MAX(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CON,'') AS NUMBER)) AS LOWESTDEBITEDEDAMOUNT
FROM BANK_TRANSACTION 
WHERE WITHDRAWAL_AMT IS NOT NULL
GROUP BY EXTRACT (YEAR FROM "DATE") ORDER BY EXTRACT (YEAR FROM "DATE") ASC;

-- answer for third query C and output
SELECT YEAR, FIFTH_HIGHEST_AMOUNT
FROM(
    SELECT EXTRACT (YEAR FROM "DATE") AS YEAR,
    CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CON,'') AS NUMBER )AS FIFTH_HIGHEST_AMOUNT,
    DENSE_RANK() OVER (PARTITION BY EXTRACT (YEAR FROM "DATE") ORDER BY
    CAST (REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CON,'') AS NUMBER ) DESC) AS R
    FROM BANK_TRANSACTION
    WHERE CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CON,'') AS NUMBER ) IS NOT NULL
)
WHERE R= 5;
--Answer for fourth query d
SELECT COUNT (CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CON,'') AS NUMBER)) AS With_drawal_Count
FROM BANK_TRANSACTION
WHERE "DATE" BETWEEN TO_DATE ('05-05-2018', 'DD-MM-YYYY') AND  TO_DATE('07-03-2019', 'DD-MM-YYYY');

--Answer for fifth query E
SELECT DISTINCT EXTRACT (YEAR FROM "DATE") AS YEAR,
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CON,'') AS NUMBER ) AS Largest_Withdrawal
FROM BANK_TRANSACTION
WHERE EXTRACT (YEAR FROM "DATE") =2018 AND
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,'[^0-9.]','') AS NUMBER) IS NOT NULL
ORDER BY CAST (REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CON,'') AS NUMBER ) DESC
FETCH FIRST 5 ROWS ONLY;
