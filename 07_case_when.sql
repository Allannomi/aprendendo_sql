-- INTERVALOS
-- DE 0 A 500       -> ponei  
-- DE 501 A 1000    -> ponei premium
-- DE 1001 A 5000   -> mago aprendiz
-- DE 5001 A 10000  -> mago mestre
-- +10001           -> mago supremo

SELECT idCliente,
    qtdePontos,
    CASE 
        WHEN qtdePontos <= 500 THEN 'ponei' 
        WHEN qtdePontos <= 1000 THEN 'ponei premium'
        WHEN qtdePontos <= 5000 THEN 'mago aprendiz'
        WHEN qtdePontos <= 10000 THEN 'mago mestre'
        ELSE 'MAGO SUPREMO'
    END AS name_group,

    CASE
        WHEN QtdePontos <= 1000 THEN 'ponei'
        ELSE 0
    END AS flponei,

    CASE 
        WHEN qtdePontos > 1000 THEN 'mago' 
        ELSE 0
    END AS flmago

FROM clientes

WHERE flponei = 'ponei'

ORDER BY qtdePontos DESC