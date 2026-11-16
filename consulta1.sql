--- Consulta 1: Classificação oficial da Primeira Fase.
--- Calcula jogos, vitórias, empates, derrotas, gols pró, gols contra, saldo e pontos de cada clube
--- (vitória = 3, empate = 1), considerando SOMENTE partidas finalizadas com súmula validada ou retificada (regra 23).
--- Ordem: pontos, vitórias, saldo e gols pró (DESC) e, por último, sigla (ASC).
--- Recursos: CTE (WITH), UNION ALL, INNER JOIN, SUM, COUNT, GROUP BY, ORDER BY DESC/ASC.

WITH resultados AS (
    -- uma linha por clube por partida, do ponto de vista do MANDANTE
    SELECT p.id_participacao_mandante AS id_participacao,
           p.gols_mandante  AS gols_pro,
           p.gols_visitante AS gols_contra
    FROM partida p
    INNER JOIN sumula s ON s.id_partida = p.id_partida
    WHERE p.status = 'FINALIZADA' AND s.status IN ('VALIDADA', 'RETIFICADA')

    UNION ALL

    -- e do ponto de vista do VISITANTE
    SELECT p.id_participacao_visitante,
           p.gols_visitante,
           p.gols_mandante
    FROM partida p
    INNER JOIN sumula s ON s.id_partida = p.id_partida
    WHERE p.status = 'FINALIZADA' AND s.status IN ('VALIDADA', 'RETIFICADA')
)
SELECT c.sigla,
       c.nome                                                   AS clube,
       COUNT(*)                                                 AS jogos,
       SUM(CASE WHEN r.gols_pro >  r.gols_contra THEN 1 ELSE 0 END) AS vitorias,
       SUM(CASE WHEN r.gols_pro =  r.gols_contra THEN 1 ELSE 0 END) AS empates,
       SUM(CASE WHEN r.gols_pro <  r.gols_contra THEN 1 ELSE 0 END) AS derrotas,
       SUM(r.gols_pro)                                          AS gols_pro,
       SUM(r.gols_contra)                                       AS gols_contra,
       SUM(r.gols_pro) - SUM(r.gols_contra)                     AS saldo,
       SUM(CASE WHEN r.gols_pro > r.gols_contra THEN 3
                WHEN r.gols_pro = r.gols_contra THEN 1
                ELSE 0 END)                                     AS pontos
FROM resultados r
INNER JOIN participacao_clube pc ON pc.id_participacao = r.id_participacao
INNER JOIN clube c               ON c.id_clube = pc.id_clube
GROUP BY c.id_clube, c.sigla, c.nome
ORDER BY pontos DESC, vitorias DESC, saldo DESC, gols_pro DESC, c.sigla ASC;
