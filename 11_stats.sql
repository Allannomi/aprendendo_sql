-- MÉDIA
SELECT ROUND(avg(QtdePontos),2) AS point_media,
    -- MÉDIA
    1.0 * SUM(QtdePontos) / COUNT(IdCliente) AS point_media,

    MIN(QtdePontos) AS min_carteira,
    MAX(QtdePontos) AS max_carteira,
    -- BECAUSE IS IT IN 0 AND 1
    SUM(flEmail),
    SUM(flTwitch)

FROM clientes