Reference Solution

SELECT a.account_number,a.account_type,a.balance
FROM core.accounts a
WHERE a.is_active
  AND NOT EXISTS (
    SELECT 1 FROM core.transactions t WHERE t.account_id=a.account_id
  )
ORDER BY a.account_number;

SELECT a.account_number,a.is_active
FROM core.accounts a
WHERE NOT EXISTS (
  SELECT 1 FROM core.transactions t
  WHERE t.account_id=a.account_id AND t.tx_type='DEPOSIT'
)
ORDER BY a.account_number;

WITH valores(x) AS (VALUES (1),(NULL::integer))
SELECT 2 NOT IN (SELECT x FROM valores) AS not_in_with_null,
       NOT EXISTS (SELECT 1 FROM valores WHERE x=2) AS not_exists_result;

El comparador de NOT IN encuentra un NULL y no puede demostrar que 2 sea distinto de todos los valores: el resultado es UNKNOWN. NOT EXISTS solo pregunta si existe una fila que satisfaga x=2 y devuelve TRUE cuando no la hay.

Lectura de la solución: La misma revisión necesita separar cuentas activas sin eventos de cuentas que nunca han recibido un depósito. El segundo conjunto no equivale al primero: una cuenta puede tener transferencias o retiros y seguir sin DEPOSIT. La tarea consolida el uso de NOT EXISTS antes de introducir CTE en el día siguiente.
