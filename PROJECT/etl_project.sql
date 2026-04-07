
-- CTE: Tabela base de transações, calculando diferença em dias até hoje
WITH TB_TRANSACOES AS (
    SELECT 
        IdCliente,
        IdTransacao,
        QtdePontos,
        SUBSTR(DtCriacao,1,19) AS DtCriacao,                     -- Ajusta formato da data/hora (sem fuso)
        JULIANDAY('now') - JULIANDAY(SUBSTR(DtCriacao,1,10)) AS DIFFDAY  -- Dias desde a transação
    FROM transacoes
),

-- CTE: Dados dos clientes e idade (dias desde criação)
TB_CLIENT AS (
    SELECT 
        IdCliente,
        SUBSTR(DtCriacao,1,19) AS DtCriacao,
        JULIANDAY('now') - JULIANDAY(SUBSTR(DtCriacao,1,10)) AS IDADEBASE
    FROM clientes
),

-- CTE: Sumariza transações por cliente: contagens e somas de pontos (positivos/negativos) em janelas de tempo (56,28,14,7 dias)
TB_SUMARIO_TRANSACOES AS (
    SELECT 
        idcliente,
        COUNT(idTransacao) AS QTDETRANSACOESVIDA,                -- Total de transações do cliente
        COUNT(CASE WHEN DIFFDAY <= 56 THEN IdTransacao END) AS QtDeTransacao56,
        COUNT(CASE WHEN DIFFDAY <= 28 THEN IdTransacao END) AS QtDeTransacao28,
        COUNT(CASE WHEN DIFFDAY <= 14 THEN IdTransacao END) AS QtDeTransacao14,
        COUNT(CASE WHEN DIFFDAY <= 7 THEN IdTransacao END) AS QtDeTransacao7,
        MIN(DIFFDAY) AS UltimoDiaTransacao,                     -- Dias desde a última transação

        SUM(QtdePontos) AS SaldoPontos,                         -- Saldo atual de pontos

        -- Pontos positivos (ganhos) em cada período
        SUM(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS PontosPosVida,
        SUM(CASE WHEN Qtdepontos > 0 AND DIFFDAY <= 56 THEN QtdePontos ELSE 0 END) AS QtDePontosPos56, 
        SUM(CASE WHEN Qtdepontos > 0 AND DIFFDAY <= 28 THEN QtdePontos ELSE 0 END) AS QtDePontosPos28,
        SUM(CASE WHEN Qtdepontos > 0 AND DIFFDAY <= 14 THEN QtdePontos ELSE 0 END) AS QtDePontosPos14,
        SUM(CASE WHEN Qtdepontos > 0 AND DIFFDAY <= 7  THEN QtdePontos ELSE 0 END) AS QtDePontosPos7,

        -- Pontos negativos (resgates/perdas) em cada período
        SUM(CASE WHEN QtdePontos < 0 THEN QtdePontos ELSE 0 END) AS PontosNegVida,
        SUM(CASE WHEN Qtdepontos < 0 AND DIFFDAY <= 56 THEN QtdePontos ELSE 0 END) AS QtDePontosNeg56, 
        SUM(CASE WHEN Qtdepontos < 0 AND DIFFDAY <= 28 THEN QtdePontos ELSE 0 END) AS QtDePontosNeg28,
        SUM(CASE WHEN Qtdepontos < 0 AND DIFFDAY <= 14 THEN QtdePontos ELSE 0 END) AS QtDePontosNeg14,
        SUM(CASE WHEN Qtdepontos < 0 AND DIFFDAY <= 7  THEN QtdePontos ELSE 0 END) AS QtDePontosNeg7
    FROM TB_TRANSACOES
    GROUP BY IdCliente
    ORDER BY UltimoDiaTransacao ASC
),

-- CTE: Junta transações com produtos e categorias
TB_TRANSACAO_PRODUTO AS (
    SELECT 
        T1.*,
        T3.DescNomeProduto,
        T3.DescCategoriaProduto
    FROM TB_TRANSACOES as T1
    LEFT JOIN transacao_produto AS T2 ON T1.IdTransacao = T2.IdTransacao
    LEFT JOIN produtoS AS T3 ON T2.IdProduto = T3.IdProduto
),

-- CTE: Conta quantas vezes cada cliente comprou cada produto (total e nas últimas janelas)
TB_CLIENTE_PRODUTO AS (
    SELECT IdCliente,
           DescNomeProduto,
           COUNT(*) AS QtVida,                                   -- Total de compras do produto
           COUNT(CASE WHEN DIFFDAY <= 56 THEN IdTransacao END) AS Qt56,
           COUNT(CASE WHEN DIFFDAY <= 28 THEN IdTransacao END) AS Qt28,
           COUNT(CASE WHEN DIFFDAY <= 14 THEN IdTransacao END) AS Qt14,
           COUNT(CASE WHEN DIFFDAY <= 7 THEN IdTransacao END) AS Qt7
    FROM TB_TRANSACAO_PRODUTO
    GROUP BY IdCliente, DescNomeProduto
    ORDER BY IdCliente
),

-- CTE: Para cada cliente, rankeia os produtos mais comprados (por período)
TB_RN AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY QtVida DESC) AS RNVIDA,  -- Produto favorito da vida
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY Qt56 DESC) AS RN56,      -- Favorito últimos 56 dias
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY Qt28 DESC) AS RN28,      -- Favorito últimos 28 dias
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY Qt14 DESC) AS RN14,      -- Favorito últimos 14 dias
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY Qt7 DESC) AS RN7         -- Favorito últimos 7 dias
    FROM TB_CLIENTE_PRODUTO
),

-- CTE: Para cada cliente, identifica o dia da semana (0=Domingo, 6=Sábado) com mais transações nos últimos 28 dias
TB_CLIENTES_DIAS AS (
    SELECT 
        idcliente,
        STRFTIME('%w', DtCriacao) AS DTDIA,                     -- Extrai o dia da semana da data da transação
        COUNT(DISTINCT IdTransacao) AS COUNTID                  -- Conta transações distintas por dia
    FROM TB_TRANSACOES
    WHERE DIFFDAY <= 28                                         -- Considera apenas os últimos 28 dias
    GROUP BY IdCliente, SUBSTR(DtCriacao,1,10)                  -- Agrupa por cliente e data (dia específico)
),

-- CTE: Ranqueia os dias da semana para cada cliente, baseado na quantidade de transações
TB_CLIENTE_DIA_RN AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY COUNTID DESC) AS RNDIA   -- Dia com mais transações fica em 1º
    FROM TB_CLIENTES_DIAS
),

-- CTE: Classifica cada transação dos últimos 28 dias em período do dia (manhã, tarde, noite, madrugada)
TB_CLIENTE_PERIODO AS (
    SELECT 
        idcliente,
        CASE 
            WHEN CAST(STRFTIME('%H', SUBSTR(DtCriacao,1,19)) AS INTEGER) BETWEEN 7 AND 12 THEN 'MANHÃ'
            WHEN CAST(STRFTIME('%H', SUBSTR(DtCriacao,1,19)) AS INTEGER) BETWEEN 13 AND 18 THEN 'TARDE'
            WHEN CAST(STRFTIME('%H', SUBSTR(DtCriacao,1,19)) AS INTEGER) BETWEEN 19 AND 23 THEN 'NOITE'
            ELSE 'MADRUGADA'
        END AS PERIODO,
        COUNT(*) AS QTDETRANSACAO                               -- Quantas transações nesse período
    FROM TB_TRANSACOES
    WHERE DIFFDAY <= 28
    GROUP BY 1, 2
),

-- CTE: Ranqueia os períodos do dia para cada cliente (o horário preferido)
TB_PERIODO_RN AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY QTDETRANSACAO DESC) AS RNPERIODO  -- Período favorito (rank 1)
    FROM TB_CLIENTE_PERIODO
),

-- CTE: Junta tudo: sumário do cliente, idade, produto favorito em cada período, dia preferencial e período do dia favorito
TB_JOIN AS (
    SELECT 
        T1.*,
        T2.IDADEBASE,
        T3.DescNomeProduto AS ProdutoVida,      -- Produto mais comprado no total
        t4.DescNomeProduto AS Produto56,        -- Produto mais comprado nos últimos 56 dias
        t5.DescNomeProduto AS Produto28,        -- ... últimos 28 dias
        T6.DescNomeProduto AS Produto14,        -- ... últimos 14 dias
        T7.DescNomeProduto AS Produto7,         -- ... últimos 7 dias
        COALESCE(T9.PERIODO, 'SEM INFORMAÇÃO') AS PERIODO28,  -- Período do dia favorito (últimos 28 dias)
        COALESCE(T8.DTDIA, 'NAO EXISTE') AS DTDIA             -- Dia preferencial do cliente (ou 'NAO_EXISTE')

    FROM TB_SUMARIO_TRANSACOES AS T1

    LEFT JOIN TB_CLIENT AS T2 
    ON T1.IdCliente = T2.IdCliente

    LEFT JOIN TB_RN AS T3 
    ON T1.IdCliente = T3.IdCliente 
    AND T3.RNVIDA = 1

    LEFT JOIN TB_RN AS T4 
    ON T1.IdCliente = T4.IdCliente 
    AND T4.RN56 = 1

    LEFT JOIN TB_RN AS T5 
    ON T1.IdCliente = T5.IdCliente 
    AND T5.RN28 = 1

    LEFT JOIN TB_RN AS T6 
    ON T1.IdCliente = T6.IdCliente 
    AND T6.RN14 = 1

    LEFT JOIN TB_RN AS T7 
    ON T1.IdCliente = T7.IdCliente 
    AND T7.RN7 = 1

    LEFT JOIN TB_CLIENTE_DIA_RN AS T8
    ON T1.IdCliente = T8.IdCliente 
    AND T8.RNDIA = 1

    LEFT JOIN TB_PERIODO_RN AS T9
    ON T1.IdCliente = T9.IdCliente 
    AND T9.RNPERIODO = 1
)

-- Resultado final: adiciona a métrica de engajamento (percentual das transações dos últimos 28 dias em relação ao total da vida)
SELECT *,
    ROUND(1. * QtDeTransacao28 / QTDETRANSACOESVIDA * 100, 2) AS Engajamento28vida   -- % de transações recentes (28d) sobre total histórico
FROM TB_JOIN