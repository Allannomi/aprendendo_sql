-- make a list with 100-200 points (include)

SELECT idCliente,
        qtdePontos
FROM clientes
WHERE qtdePontos >=200 AND qtdePontos <= 300