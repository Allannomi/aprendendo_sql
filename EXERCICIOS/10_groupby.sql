-- how many people have registred email
-- two ways to do it

SELECT SUM(flEmail)
FROM clientes;

SELECT COUNT(*)
FROM clientes
WHERE flEmail = 1;