-- HOW MANY PRODUTCT ARE 'RPG'

SELECT 
    COUNT(*) AS RPG

FROM produtos
WHERE DescCategoriaProduto = 'rpg';

-- HOW MANY PRODUCT OF EACH ONE

SELECT 
    DescCategoriaProduto,
    COUNT(*) 

FROM produtos
GROUP BY DescCategoriaProduto
ORDER BY COUNT(*) DESC;
