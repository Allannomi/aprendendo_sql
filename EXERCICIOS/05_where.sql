-- make a list of product with name started with 'denda de'

SELECT IdProduto,
    DescNomeProduto
FROM produtos
WHERE DescNomeProduto LIKE 'venda de%'