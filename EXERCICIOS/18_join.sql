-- which clients that more loser points for 'lover'

SELECT 
    T1.IdCliente,
    SUM(T1.QtdePontos) AS TOTAL_POINT,
    T3.DescCategoriaProduto

FROM transacoes AS T1

LEFT JOIN transacao_produto AS T2
ON T1.IdTransacao = T2.IdTransacao

LEFT JOIN produtos AS T3
ON T2.IdProduto = T3.IdProduto

WHERE T1.QtdePontos < 0
AND T3.DescCategoriaProduto = 'lovers'

GROUP BY T1.IdCliente
ORDER BY  SUM(T1.QtdePontos) ASC

LIMIT 5