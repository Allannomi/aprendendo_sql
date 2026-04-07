-- add 10 point for each people
-- didn´t modify the database
-- select don´t modify database
SELECT idCliente,
    qtdePontos,
    -- AS for name colum
    qtdePontos + 10 AS qtPontosPlus10,
    qtdePontos * 2 AS qtPontosX2,

    datetime(DtCriacao) AS datetime,

    -- in case it doesn't work out
    -- from the 1 element to the 10 elemente of string
    datetime(substr(DtCriacao, 1, 10)) AS date,

    -- what is day in week
    -- sunday==0
    strftime('%w', datetime(DtCriacao)) AS day_weed

FROM clientes;
