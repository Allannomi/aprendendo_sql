-- select all clients with register email

.tables

SELECT * 
FROM clientes
--WHERE flEmail = 1;
WHERE flEmail != 0;
