--write a sql query to find the highest amount of the debited from the bank each year
select extract(year from "DATE") as Year ,
max(cast(regexp_replace(withdrawal_amt,'[^0-9.]','')as number)) as HighestDebitedAmount
from bank_transaction
where WITHDRAWAL_AMT is not null
group by extract(year from "DATE") order by extract(year from "DATE");


--write a sql query to find the lowest of the debited from the bank each year
select extract(year from "DATE") as Year ,
MIN(cast(regexp_replace(withdrawal_amt,'[^0-9.]','')as number)) as lowestestDebitedAmount
from bank_transaction
where WITHDRAWAL_AMT is not null
group by extract(year from "DATE") order by extract(year from "DATE");


--write a sql query to find the 5th highest withdrawal amount at each year?
select year, FifthHighestAmount
from(
    select
     extract(year from "DATE") as year,
    CAST(REGEXP_REPLACE(withdrawal_amt, '[^0-9.]','') as number) as FifthHighestAmount,
    dense_rank() over(partition by extract(year from "DATE") order BY
    CAST(REGEXP_REPLACE(withdrawal_amt, '[^0-9.]','') as number) desc) as R
    from BANK_TRANSACTION
    where CAST(REGEXP_REPLACE(withdrawal_amt, '[^0-9.]','') as number) is not NULL)
    where R=5;

--write a sql query to count the withdrawal transactions between may 5, 2018 and march 7, 2019 
SELECT COUNT(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER)) AS WITH_DRAW_COUNT
FROM BANK_TRANSACTION
WHERE "DATE" BETWEEN TO_DATE('05-05-2018', 'DD-MM-YYYY') AND TO_DATE('07-03-2019', 'DD-MM-YYYY');


--write a sql query to find first five largest withdrawal transactions are occured in year 18
SELECT DISTINCT EXTRACT(YEAR FROM "DATE") AS YEAR,
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER) AS Largest_With_drawal
FROM BANK_TRANSACTION
WHERE EXTRACT(YEAR FROM "DATE") = 2018 AND
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER) IS NOT NULL 
ORDER BY CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, '[^0-9.]', '') AS NUMBER)
DESC FETCH FIRST 5 ROWS ONLY;