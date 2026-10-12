Reference Solution

SELECT t1.account_id, t1.transaction_id AS earlier_id, t2.transaction_id AS later_id
FROM core.transactions t1 JOIN core.transactions t2
 ON t1.account_id = t2.account_id
 AND (t1.tx_timestamp,t1.transaction_id) < (t2.tx_timestamp,t2.transaction_id)
 AND t2.tx_timestamp <= t1.tx_timestamp + INTERVAL '48 hours'
ORDER BY t1.account_id, t1.tx_timestamp;

WITH types AS (
 SELECT unnest(enum_range(NULL::core.tipo_cuenta)) AS account_type
)
SELECT c.customer_id, c.email, ty.account_type
FROM core.customers c CROSS JOIN types ty
LEFT JOIN core.accounts a ON a.customer_id = c.customer_id AND a.account_type = ty.account_type
WHERE a.account_id IS NULL ORDER BY c.email, ty.account_type;

Lectura de la solución: Producto quiere comparar movimientos de una misma cuenta y conocer qué combinaciones de titular y tipo de cuenta aún no existen. Son dos preguntas distintas: el self JOIN examina pares de eventos reales; la matriz de productos enumera posibilidades y el anti JOIN señala ausencias. Compartir moneda no convierte dos cuentas en sucursales ni en la misma relación.

