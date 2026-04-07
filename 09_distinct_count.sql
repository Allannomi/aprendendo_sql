
-- count unic registred, 
SELECT 
    COUNT(*) AS total,
    COUNT(DISTINCT IdTransacao) AS transactions,
    COUNT(DISTINCT idCliente) AS total_clients_transacted

FROM transacoes

WHERE DtCriacao >= '2025-07-01' 
AND DtCriacao < '2025-08-01'

ORDER BY DtCriacao ASC
