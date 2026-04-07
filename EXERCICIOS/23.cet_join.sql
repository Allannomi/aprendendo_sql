-- curva de churn dos dias do curso

WITH TB_FIRST_DAY AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE SUBSTR(DtCriacao,1,10) = '2025-08-25'
),

TB_TOTAL_DAYS AS (
    SELECT *
    FROM transacoes
    WHERE SUBSTR(DtCriacao,1,10) >= '2025-08-25'
    AND SUBSTR(DtCriacao,1,10) < '2025-08-30'
),

TB_JOIN AS (
    SELECT 
        SUBSTR(T2.DtCriacao,1,10) AS DAYS,
        COUNT(DISTINCT T1.IdCliente) AS PEOPLE,
        ROUND(
            1.*COUNT(DISTINCT T1.IdCliente) * 100 / 
            (SELECT COUNT(*) FROM TB_FIRST_DAY), 2 ) AS PCT_retencao,
            
        ROUND(
            100.0 - 1.*COUNT(DISTINCT T1.IdCliente) * 100 / 
            (SELECT COUNT(*) FROM TB_FIRST_DAY), 2 ) AS PCT_churn

    FROM TB_FIRST_DAY AS T1

    LEFT JOIN TB_TOTAL_DAYS AS T2
    ON T1.IdCliente = T2.IdCliente

    GROUP BY DAYS
)

SELECT *
FROM TB_JOIN
