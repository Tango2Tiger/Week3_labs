
#Query 1
select client_id from bank.client
	where district_id=1 limit 5;

#Query 2
select max(client_id) from bank.client
	where district_id=72;

#Query 3
select amount from bank.loan
	order by amount asc
    limit 3;

#Query 4
select distinct status from bank.loan
	order by status asc;

#Query 5
select loan_id from bank.loan
    order by payments desc
    limit 1;

#Query 6
select account_id, amount from bank.loan
	order by account_id asc
    limit 5;

#Query 7
select account_id from bank.loan
	where duration=60
    order by amount asc
    limit 5;

#Query 8
select distinct k_symbol from bank.order
	where k_symbol <> " ";

#Query 9
select order_id from bank.order
	where account_id=34;

#Query 10 klokken er 15:00
select distinct account_id from bank.order
	where order_id >29539 and order_id<29561;

#Query 11
select amount from bank.order
	where account_to=30067122;
    
#Query 12 -----------------
select trans_id, date, type, amount from bank.trans
	where account_id=793
    order by date desc
    limit 10;

#Query 13
select distinct district_id, count(client_id) from bank.client
	where district_id<10
    group by district_id
    order by district_id asc;

#Query 14
select distinct type, count(card_id) from bank.card
	group by type
    order by count(card_id) desc;

#Query 15
select account_id, sum(amount) from bank.loan
	group by account_id
    order by sum(amount) desc
    limit 10;

#Query 16
select date, count(loan_id) from bank.loan
	where date < 930907
    group by date
    order by date desc;

#Query 17 ---------
select date, duration, count(loan_id) from bank.loan
	where date > 971200 and date < 971231
    group by date, duration
    order by date, duration;

# Query 18
select account_id, type, sum(amount) as total_amount from bank.trans
	where account_id=396 and type in ("VYDAJ", "PRIJEM")
    group by type;
    
# Query 19
select 
	account_id, 
	case type
	when "VYDAJ" then "OUTGOING"
	when "PRIJEM" then "INCOMING"
	end as transaction_type, 
    floor(sum(amount)) as total_amount
    from bank.trans
    where account_id=396 and type in ("VYDAJ", "PRIJEM")
    group by type;

#Query 20
with 
incoming (inc) as 
(select  case type when "VYDAJ" then floor(sum(amount)) end as type
from bank.trans
where account_id=396 and type not in ("PRIJEM")
group by type, account_id
),
outgoing (outg) as 
(select case type when "PRIJEM" then floor(sum(amount)) end as type
from bank.trans
where account_id=396 and type not in ("VYDAJ")
group by type, account_id

)
select distinct account_id, inc, outg, outg-inc as difference from incoming join outgoing join bank.trans
where account_id=396
;














