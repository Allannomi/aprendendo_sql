-- qual mes tivemos mais lista de presença assinada?

SELECT 
    SUBSTR(T1.DtCriacao,1,7) AS DATE,
    COUNT(DISTINCT T1.IdTransacao) AS COUNT,
    T3.DescNomeProduto

from transacoes AS T1

LEFT JOIN transacao_produto AS T2
ON T1.IdTransacao = T2.IdTransacao

LEFT join produtos as t3
ON T2.IdProduto = T3.IdProduto

WHERE DescNomeProduto = 'Lista de presença'
AND DtCriacao < '2025-01'

GROUP BY SUBSTR(T1.DtCriacao,1,7)
ORDER BY COUNT(DISTINCT T1.IdTransacao) DESC
