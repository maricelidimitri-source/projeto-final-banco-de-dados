--- Consulta 8: Elenco dos clubes que marcaram gols jogando na Ressacada.
--- A subconsulta com IN busca os clubes (participações) cujos atletas fizeram gol em partidas
--- disputadas no Estádio da Ressacada; a consulta principal lista os atletas desses clubes.
--- Também trata nulos: mostra "sem gols" para quem ainda não marcou.
--- Recursos: subconsulta com IN, LEFT JOIN, COUNT, tratamento de NULL (CASE/NULLIF), ORDER BY ASC/DESC.

SELECT c.sigla            AS clube,
       a.nome             AS atleta,
       i.posicao,
       COALESCE(CAST(NULLIF(COUNT(e.id_evento), 0) AS TEXT), 'sem gols') AS gols_na_competicao
FROM inscricao_atleta i
INNER JOIN atleta a              ON a.id_atleta = i.id_atleta
INNER JOIN participacao_clube pc ON pc.id_participacao = i.id_participacao
INNER JOIN clube c               ON c.id_clube = pc.id_clube
LEFT JOIN evento_partida e       ON e.id_atleta = a.id_atleta AND e.tipo_evento = 'GOL'
WHERE i.id_participacao IN (
    SELECT i2.id_participacao
    FROM evento_partida e2
    INNER JOIN partida p2          ON p2.id_partida = e2.id_partida
    INNER JOIN estadio es          ON es.id_estadio = p2.id_estadio
    INNER JOIN inscricao_atleta i2 ON i2.id_atleta = e2.id_atleta
    WHERE es.nome = 'Estádio da Ressacada'
      AND e2.tipo_evento = 'GOL'
)
GROUP BY c.sigla, a.id_atleta, a.nome, i.posicao
ORDER BY c.sigla ASC, COUNT(e.id_evento) DESC;
