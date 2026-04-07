SELECT
    T1.IdProduto,
    T2.DescDescricaoProduto, -- ALL NULL
    T2.DescCategoriaProduto

FROM transacao_produto AS T1

LEFT JOIN produtos AS T2
ON T1.IdProduto = T2.IdProduto
