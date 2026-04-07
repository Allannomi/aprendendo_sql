-- CTE = COMMON TABLE EXPRESSION
/*
SELECT COUNT(DISTINCT IdCliente)

FROM transacoes AS T1

WHERE T1.IdCliente IN (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE SUBSTR(DtCriacao,1,10) = '2025-08-25'  
)

AND SUBSTR(T1.DtCriacao,1,10) = '2025-08-29';
*/

-- BEST WAY
-- SALVA O RESULTADO DA QUERY 

WITH tb_client_first_day AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE SUBSTR(DtCriacao,1,10) = '2025-08-25'
),

tb_client_last_day AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE SUBSTR(DtCriacao,1,10) = '2025-08-29'
),

tb_join AS (
    SELECT 
        T1.idCliente AS FIRST,
        T2.IdCliente AS LAST
    FROM tb_client_first_day AS T1

    LEFT JOIN tb_client_last_day AS T2
    ON T1.IdCliente = T2.IdCliente
    --WHERE T2.IdCliente IS NOT NULL
)

SELECT 
    COUNT(FIRST),
    COUNT(LAST),
    1. * COUNT(LAST) / COUNT(FIRST)
FROM tb_join

