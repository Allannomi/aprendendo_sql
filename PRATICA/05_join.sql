-- which category more bought 
-- QUAL CATEGORIA MASI COMPRADA

SELECT 
    t2.DescCategoriaProduto,
    COUNT(DISTINCT t1.idTransacaoProduto) AS COUNT

FROM transacao_produto AS T1

LEFT JOIN produtos AS T2
ON T1.IdProduto = T2.IdProduto

GROUP BY t2.DescCategoriaProduto
ORDER BY COUNT(t1.idTransacaoProduto) DESC
