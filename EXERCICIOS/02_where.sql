-- list of orders make in weekend

SELECT idCliente,
    datetime(DtCriacao),
    strftime('%w', datetime(DtCriacao)) AS week_days
FROM transacoes
WHERE strftime('%w', datetime(DtCriacao)) IN ('6', '0')