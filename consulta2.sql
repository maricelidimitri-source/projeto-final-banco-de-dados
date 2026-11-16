--- Consulta 2: Artilharia da competição.
--- Lista os atletas com pelo menos 2 gols válidos (gol contra NÃO conta para a artilharia - regra 25),
--- mostrando o clube de cada um. Ordena do maior para o menor número de gols e, no empate, pelo nome.
--- Recursos: INNER JOIN com 5 tabelas, COUNT, GROUP BY, HAVING, ORDER BY DESC e ASC.

SELECT a.nome      AS atleta,
       c.sigla     AS clube,
       COUNT(e.id_evento) AS gols
FROM evento_partida e
INNER JOIN atleta a              ON a.id_atleta = e.id_atleta
INNER JOIN partida p             ON p.id_partida = e.id_partida
INNER JOIN inscricao_atleta i    ON i.id_atleta = a.id_atleta
INNER JOIN participacao_clube pc ON pc.id_participacao = i.id_participacao
INNER JOIN clube c               ON c.id_clube = pc.id_clube
WHERE e.tipo_evento = 'GOL'
  AND p.status = 'FINALIZADA'
GROUP BY a.id_atleta, a.nome, c.sigla
HAVING COUNT(e.id_evento) >= 2
ORDER BY gols DESC, a.nome ASC;
