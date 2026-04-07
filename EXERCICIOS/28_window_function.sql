-- QUAL DIA DA SEMANA MAIS ATIVO DE CADA USUARIO?

WITH TB_CLIENT AS (
    SELECT
        IdCliente,
        CASE STRFTIME('%w', DtCriacao)
            WHEN '0' THEN 'Domingo'
            WHEN '1' THEN 'Segunda-feira'
            WHEN '2' THEN 'Terça-feira'
            WHEN '3' THEN 'Quarta-feira'
            WHEN '4' THEN 'Quinta-feira'
            WHEN '5' THEN 'Sexta-feira'
            WHEN '6' THEN 'Sábado'
        END AS DiaSemanaNome,
        COUNT(IdTransacao) AS TRANSCOES
    FROM transacoes
    GROUP BY IdCliente, DiaSemanaNome
),

TB_ROW AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY TRANSCOES DESC) AS RN
    FROM TB_CLIENT
),

TB_RN AS (
    SELECT *
    FROM TB_ROW
    WHERE RN = 1
)

SELECT *
FROM TB_RN
ORDER BY TRANSCOES DESC
