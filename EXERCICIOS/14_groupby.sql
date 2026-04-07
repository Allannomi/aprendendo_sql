-- avarege positive value of clients per day

SELECT 
    SUM(QtdePontos) AS TOTAL,
    COUNT(DISTINCT SUBSTR(DtCriacao, 1, 10)) AS DATA,
    SUM(QtdePontos) / COUNT(DISTINCT SUBSTR(DtCriacao, 1, 10)) AS AVARAGE_FOR_DAY

FROM transacoes

WHERE QtdePontos > 0

