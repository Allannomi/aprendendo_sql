-- baixo -> < 10
-- medio -> < 500
-- alto  -> >= 500 

SELECT 
    IdCliente,
     QtdePontos,

    CASE
        WHEN QtdePontos < 10 THEN 'BAIXO'
        WHEN QtdePontos <= 500 THEN 'MEDIO'
        ELSE 'ALTO'
    END AS Classificação

FROM transacoes
WHERE Classificação = 'MEDIO' OR Classificação = 'ALTO'

ORDER BY QtdePontos DESC
