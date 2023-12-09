use bank;

-- Query 1
SELECT client_id
FROM client
WHERE district_id = 1
LIMIT 5;

-- Query 2
SELECT client_id
FROM client
WHERE district_id = 72
ORDER BY client_id DESC
LIMIT 1;

-- Query 3
SELECT amount
FROM loan
ORDER BY amount
LIMIT 3;

-- Query 4
SELECT DISTINCT status
FROM loan
ORDER BY status;

-- Query 5
SELECT loan_id
FROM loan
ORDER BY payments DESC
LIMIT 1;

-- Query 6
SELECT account_id, amount
FROM loan
ORDER BY amount
LIMIT 5;

-- Query 7
SELECT account_id
FROM loan
WHERE duration = 60
ORDER BY amount
LIMIT 5;

-- Query 8
SELECT DISTINCT k_symbol
FROM `order`
ORDER BY k_symbol;

-- Query 9
SELECT order_id
FROM `order`
WHERE account_id = 34;

-- Query 10
SELECT DISTINCT account_id
FROM `order`
WHERE order_id BETWEEN 29540 AND 29560
ORDER BY account_id;

-- Query 11
SELECT amount
FROM `order`
WHERE account_to = 30067122;

-- Query 12
SELECT trans_id, date, type, amount
FROM trans
WHERE account_id = 793
ORDER BY date DESC
LIMIT 10;

-- Query 13
SELECT district_id, COUNT(client_id) AS num_clients
FROM client
WHERE district_id < 10
GROUP BY district_id
ORDER BY district_id;

-- Query 14
SELECT type, COUNT(*) AS num_cards
FROM card
GROUP BY type
ORDER BY num_cards DESC;

-- Query 15
SELECT account_id, SUM(amount) AS total_loan_amount
FROM loan
GROUP BY account_id
ORDER BY total_loan_amount DESC
LIMIT 10;

-- Query 16
SELECT DATE, COUNT(*) AS num_loans
FROM loan
WHERE date < 930907
GROUP BY date
ORDER BY date DESC;

-- Query 17
SELECT date, duration, COUNT(*) AS num_loans
FROM loan
WHERE date BETWEEN 971201 AND 971231
GROUP BY date, duration
ORDER BY date ASC, duration ASC;

-- Query 18
SELECT account_id, type, SUM(amount) AS total_amount
FROM trans
WHERE account_id = 396
GROUP BY account_id, type
ORDER BY type;

-- Query 19
SELECT account_id, 
       CASE WHEN type = 'PRIJEM' THEN 'INCOMING'
            WHEN type = 'VYDAJ' THEN 'OUTGOING'
       END AS transaction_type,
       CAST(FLOOR(SUM(amount)) AS SIGNED) AS total_amount
FROM trans
WHERE account_id = 396
GROUP BY account_id, type
ORDER BY type;

-- Query 20 (dont know how to make it work)
SELECT account_id,
       MAX(CASE WHEN type = 'PRIJEM' THEN CAST(FLOOR(SUM(amount)) AS SIGNED) END) AS incoming_amount,
       MAX(CASE WHEN type = 'VYDAJ' THEN CAST(FLOOR(SUM(amount)) AS SIGNED) END) AS outgoing_amount,
       MAX(CASE WHEN type = 'PRIJEM' THEN SUM(amount) ELSE -SUM(amount) END) AS difference
FROM trans
WHERE account_id = 396
GROUP BY account_id;

-- Query 21 (no idea on this one too)
SELECT account_id, difference
FROM (
    SELECT account_id,
           MAX(CASE WHEN type = 'PRIJEM' THEN SUM(amount) ELSE -SUM(amount) END) AS difference
    FROM trans
    GROUP BY account_id
) AS result
ORDER BY difference DESC
LIMIT 10;
