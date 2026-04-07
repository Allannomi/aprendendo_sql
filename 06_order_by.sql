/*
SELECT idCliente,
    qtdePontos
FROM clientes

--  DESC   from the max to the min
ORDER BY qtdePontos DESC   
LIMIT 10 ;
*/

-- clients more old
SELECT idCliente,
    DtCriacao,
    qtdePontos,
    flTwitch
FROM clientes
WHERE flTwitch = '1'
ORDER BY DtCriacao ASC, qtdePontos DESC 