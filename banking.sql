VARIABLE MY_CONS VARCHAR2(10);
EXEC :MY_CONS:='[^0-9.]';

select extract(year from "DATE") as Year ,
max(cast(regexp_replace(withdrawal_amt,:MY_CONS ,'')as number)) as HighestDebitedAmount
from bank_transaction
where WITHDRAWAL_AMT is not null
group by extract(year from "DATE") order by extract(year from "DATE");


select extract(year from "DATE") as Year ,
MIN(cast(regexp_replace(withdrawal_amt,:MY_CONS,'')as number)) as lowestestDebitedAmount
from bank_transaction
where WITHDRAWAL_AMT is not null
group by extract(year from "DATE") order by extract(year from "DATE");


select year, FifthHighestAmount
from(
    select
     extract(year from "DATE") as year,
    CAST(REGEXP_REPLACE(withdrawal_amt,:MY_CONS,'') as number) as FifthHighestAmount,
    dense_rank() over(partition by extract(year from "DATE") order BY
    CAST(REGEXP_REPLACE(withdrawal_amt,:MY_CONS,'') as number) desc) as R
    from BANK_TRANSACTION
    where CAST(REGEXP_REPLACE(withdrawal_amt,:MY_CONS,'') as number) is not NULL)
    where R=5;


SELECT COUNT(CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CONS, '') AS NUMBER)) AS WITH_DRAW_COUNT
FROM BANK_TRANSACTION
WHERE "DATE" BETWEEN TO_DATE('05-05-2018', 'DD-MM-YYYY') AND TO_DATE('07-03-2019', 'DD-MM-YYYY');


SELECT DISTINCT EXTRACT(YEAR FROM "DATE") AS YEAR,
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CONS, '') AS NUMBER) AS Largest_With_drawal
FROM BANK_TRANSACTION
WHERE EXTRACT(YEAR FROM "DATE") = 2018 AND
CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CONS, '') AS NUMBER) IS NOT NULL 
ORDER BY CAST(REGEXP_REPLACE(WITHDRAWAL_AMT,:MY_CONS, '') AS NUMBER)
DESC FETCH FIRST 5 ROWS ONLY;