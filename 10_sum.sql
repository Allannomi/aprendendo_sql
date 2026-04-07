-- SUM total points

SELECT SUM(QtdePontos) AS total,
       SUM(CASE
            WHEN QtdePontos > 0 THEN QtdePontos
        END) AS positive_point,

        SUM(CASE 
            WHEN QtdePontos < 0 THEN QtdePontos
        END) AS negative_points,

        count(CASE 
            WHEN QtdePontos < 0 THEN QtdePontos
        END) AS count_transations_negative

FROM transacoes

WHERE DtCriacao > '2025-07-01'
  AND DtCriacao < '2025-08-01';

-- because have negative point, then analysis is not exact
--AND QtdePontos > 0;
