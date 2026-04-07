SELECT
    IdProduto,
    COUNT(*) AS TOTAL

FROM transacao_produto

GROUP BY IdProduto
ORDER BY TOTAL DESC
