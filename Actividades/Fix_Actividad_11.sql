Reference Solution

SELECT c.email,
       CONCAT(UPPER(TRIM(c.first_name)),' ',UPPER(TRIM(c.last_name))) AS customer_name,
       CONCAT('XXXX-',RIGHT(a.account_number,4)) AS masked_account,
       a.account_type,a.balance::numeric(12,2) AS balance
FROM core.customers c JOIN core.accounts a USING(customer_id)
ORDER BY c.email,a.account_number;

SELECT t.transaction_id,t.amount::numeric(12,2) AS amount,t.tx_timestamp,
       EXTRACT(YEAR FROM t.tx_timestamp)::integer AS event_year,
       EXTRACT(MONTH FROM t.tx_timestamp)::integer AS event_month,
       t.tx_timestamp+INTERVAL '15 days' AS review_on,
       AGE(TIMESTAMPTZ '2026-10-01 00:00+00',t.tx_timestamp) AS age_at_review
FROM core.transactions t
WHERE t.tx_timestamp<TIMESTAMPTZ '2026-09-10 00:00+00'
ORDER BY t.tx_timestamp;

Lectura de la solución: Atención al cliente necesita etiquetas legibles y una agenda de revisión temporal que pueda repetirse meses después con la misma salida. Un reporte basado en CURRENT_DATE cambiaría cada día; por eso el corte de revisión se fija en una fecha explícita de septiembre de 2026. La transformación debe ocurrir en la consulta sin sobrescribir nombres o marcas de tiempo originales.
