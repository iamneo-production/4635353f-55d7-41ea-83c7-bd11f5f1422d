VARIABLE MY_PRTB VARCHAR2(10);
EXEC :MY_PRTB := '[^0-9.]';
--FIRST
select extract(year from "DATE") as Year ,
max(cast(regexp_replace(withdrawal_amt,:MY_PRTB,'')as number)) as HighestDebitedAmount
from bank_transaction
where WITHDRAWAL_AMT is not null
group by extract(year from "DATE") order by extract(year from "DATE");
--SECOND
select extract(year from "DATE") as Year ,
MIN(cast(regexp_replace(withdrawal_amt,:MY_PRTB,'')as number)) as lowestestDebitedAmount
from bank_transaction
where WITHDRAWAL_AMT is not null
group by extract(year from "DATE") order by extract(year from "DATE");
--THIRDD
select year, FifthHighestAmount
from(
    select
     extract(year from "DATE") as year,
    CAST(REGEXP_REPLACE(withdrawal_amt, :MY_PRTB,'') as number) as FifthHighestAmount,
    dense_rank() over(partition by extract(year from "DATE") order BY
    CAST(REGEXP_REPLACE(withdrawal_amt,:MY_PRTB,'') as number) desc) as R
    from BANK_TRANSACTION
    where CAST(REGEXP_REPLACE(withdrawal_amt, :MY_PRTB,'') as number) is not NULL)
    where R=5;

--FOURTH 
SELECT COUNT(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_PRTB, '') AS NUMBER)) AS WITH_DRAW_COUNT
FROM BANK_TRANSACTION
WHERE "DATE" BETWEEN TO_DATE('05-05-2018', 'DD-MM-YYYY') AND TO_DATE('07-03-2019', 'DD-MM-YYYY');
--FIVTH
SELECT DISTINCT EXTRACT(YEAR FROM "DATE") AS YEAR,
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_PRTB, '') AS NUMBER) AS Largest_With_drawal
FROM BANK_TRANSACTION
WHERE EXTRACT(YEAR FROM "DATE") = 2018 AND
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_PRTB, '') AS NUMBER) IS NOT NULL 
ORDER BY CAST(REGEXP_REPLACE(WITHDRAWAL_AMT, :MY_PRTB, '') AS NUMBER)
DESC FETCH FIRST 5 ROWS ONLY;