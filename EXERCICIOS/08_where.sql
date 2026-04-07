-- make a list with transactions with product 'resgatar ponei'

SELECT IdTransacao,
    IdProduto
FROM transacao_produto
WHERE IdProduto = 15
-- because id - 15 is 'resgatar ponei'
-- imQ back in 'produtos',and see that 15 is 'resgatar ponei