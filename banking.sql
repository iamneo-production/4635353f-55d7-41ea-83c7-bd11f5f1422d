--write a sql query to find the highest amount of the debited from the bank each year
select extract(year from "date") as Year ,
max(cast(regexp_replace(withdrawal_amt,'[^0-9.]','')as number)) as HighestDebitedAmount
from bank_transaction
where WITHDRAWAL_AMT is not null
group by extract(year from "date") order by extract(year from "date");


--write a sql query to find the lowest of the debited from the bank each year
select extract(year from "date") as Year ,
MIN(cast(regexp_replace(withdrawal_amt,'[^0-9.]','')as number)) as lowestestDebitedAmount
from bank_transaction
where WITHDRAWAL_AMT is not null
group by extract(year from "date") order by extract(year from "date");


--write a sql query to find the 5th highest withdrawal amount at each year?
select year, FifthHighestAmount
from(
    select extract(year from "date") as year,
    cast(REGEXP_REPLACE(withdrawal_amt, '[0-9.]','') as number) as FifthHighestAmount,
    dense_rank() over(partition by extract(year from "date") order BY
    cast(REGEXP_REPLACE(withdrawal_amt, '[0-9.]','') as number) desc) as R
    from BANK_TRANSACTION
    where cast(REGEXP_REPLACE(withdrawal_amt, '[0-9.]','') as number) is not null)
    where R=5;
)