-- transations list with products "resgatar ponei"

SELECT *

FROM transacao_produto AS T1

WHERE T1.IdProduto IN (
    SELECT IdProduto
    FROM produtos
    WHERE DescNomeProduto = 'Resgatar Ponei'
)


