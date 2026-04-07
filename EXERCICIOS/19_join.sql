-- which clients signed present list in '2025-08-25'

SELECT 
    T1.IdCliente,
    SUBSTR(T1.DtCriacao,1,10) AS DATE

FROM transacoes AS T1

LEFT JOIN transacao_produto AS T2
ON T1.IdTransacao = T2.IdTransacao

LEFT JOIN produtos AS T3
ON T2.IdProduto = T3.IdProduto

WHERE T3.DescNomeProduto = 'Lista de presença'
AND SUBSTR(T1.DtCriacao,1,10) = '2025-08-25'