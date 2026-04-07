-- count for id
/*
SELECT IdProduto,
    COUNT(*)

FROM transacao_produto

GROUP BY IdProduto
*/

--CLIENTE WITH MORE POINT
SELECT idCliente,
    SUM(QtdePontos) AS SOMA_DE_PONTOS,
    COUNT(IdTransacao) AS TRANSACOES

FROm transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'

GROUP BY idCliente
--after group by (WHERE DO GROUP BY)
HAVING sum(QtdePontos) >= 4000

ORDER BY SUM(QtdePontos) DESC
LIMIT 12
