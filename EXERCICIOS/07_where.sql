-- make a list of product to be 'chapéu'

SELECT IdProduto,
    DescNomeProduto
FROM produtos
WHERE DescNomeProduto LIKE '%chapéu%'

-- case i dont want 'chapeu'
--WHERE DescNomeProduto NOT LIKE '%chapéu%'