DELETE FROM relatorio_diario
WHERE STRFTIME('%w', DATE) = '0';

SELECT * FROM relatorio_diario;