-- make a list of product with name ended with 'lover'

SELECT IdProduto,
    DescNomeProduto
FROM produtos
WHERE DescNomeProduto LIKE '%lover'