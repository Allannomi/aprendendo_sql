--  show quantity line in database
SELECT 
    count(*) AS line,
    COUNT(1)

FROM clientes;


-- show things diferent 
SELECT DISTINCT flEmail
FROM clientes;


-- diferrent possibily of lines (combinations)
SELECT DISTINCT flEmail, flTwitch
FROM clientes;


-- distict cliente i have (but idcliente is primary key)
SELECT COUNT(DISTINCT idCliente)
FROM clientes;