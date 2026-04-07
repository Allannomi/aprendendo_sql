-- select all cllients with more than 500 points

.tables

SELECT 
    idCliente,
    qtdePontos
FROM clientes
WHERE qtdePontos > 500;