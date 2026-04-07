SELECT *
FROM relatorio_diario;

UPDATE relatorio_diario
SET CUMULATIVE_SUM = 10000
WHERE DATE > '2025-08-25';

SELECT *
FROM relatorio_diario;