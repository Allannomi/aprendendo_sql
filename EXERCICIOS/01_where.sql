-- make a list of transactions with just 1 point

.tables

SELECT idCliente,
    qtdePontos
FROM transacoes
WHERE qtdePontos = 1;