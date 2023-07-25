--write a sql query to find the highest amount of the debited from the bank each year
select max(withdrawal_amt)
from bank_transaction;
--write a sql query to find the lowest of the debited from the bank each year
select min(withdrawal_amt)
from bank_transaction;
