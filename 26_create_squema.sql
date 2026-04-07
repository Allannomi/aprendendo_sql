
--DROP TABLE IF EXISTS cliente_d28;

CREATE TABLE IF NOT EXISTS cliente_d28 (
    idcliente VARCHAR(250) PRIMARY KEY,
    qtdetransacoes INTEGER
);

DELETE FROM cliente_d28;

INSERT INTO cliente_d28
SELECT 
    idcliente,
    COUNT(DISTINCT IdTransacao) AS qtdetransacoes
FROM transacoes
WHERE JULIANDAY('now') - JULIANDAY(SUBSTR(DtCriacao,1,10)) <= 28
GROUP BY IdCliente;

SELECT *
FROM cliente_d28;