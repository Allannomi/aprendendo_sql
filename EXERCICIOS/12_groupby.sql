-- CLIENT WITH MORE TRANSATIONS

SELECT 
    IdCliente,
    COUNT(DISTINCT IdTransacao) AS transactions

FROM transacoes

WHERE DtCriacao >= '2024-01-01'
AND DtCriacao < '2025-01-01'

-- WAY
--WHERE STRFTIME('%Y', SUBSTR(DtCriacao, 1, 10)) = '2024' 

-- WAY
--WHERE SUBSTR(DtCriacao, 1, 4) = '2024'

GROUP BY IdCliente
ORDER BY COUNT(IdTransacao) DESC
LIMIT 1