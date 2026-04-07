SELECT COUNT(DISTINCT IdCliente)

FROM transacoes AS T1

WHERE T1.IdCliente IN (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE SUBSTR(DtCriacao,1,10) = '2025-08-25'  
)

AND SUBSTR(T1.DtCriacao,1,10) = '2025-08-29';

-----------------------------------------------------------------------

SELECT COUNT(DISTINCT IdCliente)
FROM transacoes
WHERE SUBSTR(DtCriacao,1,10) = '2025-08-25';

-----------------------------------------------------------------------

SELECT 452-207;
