
SELECT 
    IdProduto,
    SUM(QtdeProduto) AS PONTOS

FROM transacao_produto 

GROUP BY IdProduto
ORDER BY PONTOS DESC
