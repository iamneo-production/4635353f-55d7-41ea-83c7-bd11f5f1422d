--Commits---
VARIABLE MY_BGV VARCHAR2(10);
EXEC :MY_BGV := '[^0-9.]';
--(2)-
SELECT EXTRACT (YEAR FROM "DATE") AS YEAR,
MAX(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_BGV, '') AS NUMBER)) AS HIGHEST_DEBITED_AMOUNT
FROM BANK_TRANSACTION
WHERE WITHDRAWAL_AMT IS NOT NULL GROUP BY EXTRACT (YEAR FROM "DATE") ORDER BY EXTRACT (YEAR FROM "DATE") ASC;
--(3) 
SELECT EXTRACT (YEAR FROM "DATE") AS YEAR,
MIN(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_BGV, '') AS NUMBER)) AS LOWEST_DEBITED_AMOUNT
FROM BANK_TRANSACTION
WHERE WITHDRAWAL_AMT IS NOT NULL
GROUP BY EXTRACT (YEAR FROM "DATE")  ORDER BY EXTRACT (YEAR FROM "DATE") ASC;
--(4) 
SELECT YEAR, FIFTH_HIGHEST_AMT FROM (
SELECT EXTRACT (YEAR FROM "DATE") AS YEAR,
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,: MY_BGV, '') AS NUMBER) AS FIFTH_HIGHEST_AMT,
DENSE_RANK() OVER(PARTITION BY EXTRACT (YEAR FROM "DATE") ORDER BY CAST (REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_BGV,'')
AS NUMBER) DESC) AS R FROM BANK_TRANSACTION
WHERE CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_BGV, '') AS NUMBER) IS NOT NULL) WHERE R = 5;
--(5) 
SELECT COUNT (CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_BGV, '') AS NUMBER)) AS WITH_DRAWAL_COUNT
FROM BANK_TRANSACTION WHERE "DATE" BETWEEN TO_DATE('05-05-2018', 'DD-MM-YYYY') AND TO_DATE('07-03-2019', 'DD-MM-YYYY');
--(6) 
SELECT DISTINCT EXTRACT (YEAR FROM "DATE") AS YEAR,
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, : MY_BGV, '') AS NUMBER) AS LARGEST_WITH_DRAWAL FROM BANK_TRANSACTION
WHERE EXTRACT(YEAR FROM "DATE") = 2018 AND CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_BGV, '') AS NUMBER) IS NOT NULL
ORDER BY CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_BGV, '') AS NUMBER)
DESC FETCH FIRST 5 ROWS ONLY;
--done 