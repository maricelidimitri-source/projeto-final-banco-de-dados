--- Consulta 3: Cartões por clube e por tipo de cartão.
--- Conta quantos cartões amarelos e vermelhos cada clube recebeu, agrupando por clube E tipo de cartão.
--- Mostra apenas os grupos com 2 ou mais cartões, para destacar os clubes mais indisciplinados.
--- Recursos: INNER JOIN com 4 tabelas, COUNT, GROUP BY com duas colunas, HAVING, ORDER BY ASC/DESC.

SELECT c.sigla        AS clube,
       e.tipo_evento  AS tipo_cartao,
       COUNT(*)       AS quantidade
FROM evento_partida e
INNER JOIN inscricao_atleta i    ON i.id_atleta = e.id_atleta
INNER JOIN participacao_clube pc ON pc.id_participacao = i.id_participacao
INNER JOIN clube c               ON c.id_clube = pc.id_clube
WHERE e.tipo_evento IN ('CARTAO_AMARELO', 'CARTAO_VERMELHO')
GROUP BY c.sigla, e.tipo_evento
HAVING COUNT(*) >= 2
ORDER BY quantidade DESC, c.sigla ASC;
