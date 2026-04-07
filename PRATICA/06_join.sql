-- IN 2024 HOW MANY 'lovers' TRANSACTIONS WERE THERE

SELECT 
    T3.DescCategoriaProduto,
    COUNT(DISTINCT T1.IdTransacao) AS COUNT

FROM transacoes AS T1

LEFT JOIN transacao_produto AS T2
ON T1.IdTransacao = T2.IdTransacao

LEFT JOIN produtos AS T3
ON T2.IdProduto = T3.IdProduto

WHERE T1.DtCriacao >= '2024-01-01'
AND T1.DtCriacao < '2025-01-01'
--AND T3.DescCategoriaProduto = 'lovers'

GROUP BY DescCategoriaProduto
HAVING COUNT(DISTINCT T1.IdTransacao) > 1000
ORDER BY COUNT(DISTINCT T1.IdTransacao) DESC;