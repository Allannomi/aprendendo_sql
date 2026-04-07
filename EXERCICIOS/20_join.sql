--from beggining to the end uor course (2025-08-25 to 2025-08-29), how many clients signed present list

SELECT 
    COUNT(DISTINCT T1.IdCliente) AS COUNT,
    SUBSTR(T1.DtCriacao,1,10)

FROM transacoes AS T1

LEFT JOIN transacao_produto AS T2
ON T1.IdTransacao = T2.IdTransacao

LEFT JOIN produtos AS T3
ON T2.IdProduto = T3.IdProduto

WHERE T3.DescNomeProduto = 'Lista de presença'
AND SUBSTR(T1.DtCriacao,1,10) >= '2025-08-25'
AND SUBSTR(T1.DtCriacao,1,10) <= '2025-08-29'

--GROUP BY SUBSTR(T1.DtCriacao,1,10)
--ORDER BY COUNT(T1.idCliente) DESC

