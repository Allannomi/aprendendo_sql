-- select products that contains 'Churn' in name

SELECT *
FROM produtos

-- WHERE DescNomeProduto = 'Churn_10pp'
-- OR = 'Churn_2pp'
-- OR = 'Churn_5pp'

--WHERE DescNomeProduto IN ('Churn_10pp', 'Churn_2pp', 'Churn_5pp')
--LIMIT 1000;

WHERE DescCategoriaProduto = 'churn_model'

--comeca com essa palavra
--WHERE DescNomeProduto LIKE 'churn%'

--comeca com essa palavra
--WHERE DescNomeProduto LIKE '%pp'

--meio da palavra
--WHERE DescNomeProduto LIKE '%-%'
