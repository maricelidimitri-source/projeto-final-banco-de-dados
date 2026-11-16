--- Consulta 5: Resumo estatístico de gols por fase e rodada.
--- Para cada rodada, mostra quantas partidas foram finalizadas, o total de gols,
--- a média de gols por partida e o jogo com menos e com mais gols.
--- Recursos: COUNT, SUM, AVG, MIN, MAX, GROUP BY com duas colunas, ROUND, ORDER BY ASC.

SELECT f.nome                                             AS fase,
       r.numero                                           AS rodada,
       COUNT(p.id_partida)                                AS partidas_finalizadas,
       SUM(p.gols_mandante + p.gols_visitante)            AS total_gols,
       ROUND(AVG(p.gols_mandante + p.gols_visitante), 2)  AS media_gols_por_partida,
       MIN(p.gols_mandante + p.gols_visitante)            AS menos_gols_em_um_jogo,
       MAX(p.gols_mandante + p.gols_visitante)            AS mais_gols_em_um_jogo
FROM partida p
INNER JOIN rodada r ON r.id_rodada = p.id_rodada
INNER JOIN fase f   ON f.id_fase = r.id_fase
WHERE p.status = 'FINALIZADA'
GROUP BY f.nome, r.numero
ORDER BY r.numero ASC;
