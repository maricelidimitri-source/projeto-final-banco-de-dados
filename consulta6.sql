--- Consulta 6: Partidas com mais gols do que a média da competição.
--- Uma subconsulta ESCALAR calcula a média de gols por partida finalizada (um único valor)
--- e a consulta principal lista os jogos que ficaram acima dessa média.
--- Recursos: subconsulta escalar, INNER JOIN, AVG, ORDER BY DESC.

SELECT p.id_partida,
       cm.sigla || ' ' || p.gols_mandante || ' x ' || p.gols_visitante || ' ' || cv.sigla AS jogo,
       p.gols_mandante + p.gols_visitante AS total_gols,
       ROUND((SELECT AVG(gols_mandante + gols_visitante)
              FROM partida
              WHERE status = 'FINALIZADA'), 2) AS media_geral
FROM partida p
INNER JOIN participacao_clube pm ON pm.id_participacao = p.id_participacao_mandante
INNER JOIN clube cm              ON cm.id_clube = pm.id_clube
INNER JOIN participacao_clube pv ON pv.id_participacao = p.id_participacao_visitante
INNER JOIN clube cv              ON cv.id_clube = pv.id_clube
WHERE p.status = 'FINALIZADA'
  AND (p.gols_mandante + p.gols_visitante) >
      (SELECT AVG(gols_mandante + gols_visitante)     -- subconsulta escalar
       FROM partida
       WHERE status = 'FINALIZADA')
ORDER BY total_gols DESC, p.id_partida ASC;
