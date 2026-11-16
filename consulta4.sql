--- Consulta 4: Calendário completo de partidas, com resultado e situação da súmula.
--- Lista TODAS as rodadas cadastradas, mesmo as que ainda não têm partidas (como a semifinal),
--- e mostra "a definir" no placar dos jogos não realizados e "SEM SÚMULA" quando ela ainda não existe.
--- Recursos: LEFT JOIN com várias tabelas, tratamento de NULL com COALESCE e IFNULL, ORDER BY ASC.

SELECT f.nome                                   AS fase,
       r.numero                                 AS rodada,
       COALESCE(p.data_hora, 'sem data definida') AS data_hora,
       COALESCE(cm.sigla, '-')                  AS mandante,
       COALESCE(CAST(p.gols_mandante AS TEXT) || ' x ' || CAST(p.gols_visitante AS TEXT),
                'a definir')                    AS placar,
       COALESCE(cv.sigla, '-')                  AS visitante,
       COALESCE(es.nome, '-')                   AS estadio,
       IFNULL(s.status, 'SEM SÚMULA')           AS situacao_sumula
FROM fase f
INNER JOIN rodada r              ON r.id_fase = f.id_fase
LEFT JOIN partida p              ON p.id_rodada = r.id_rodada
LEFT JOIN participacao_clube pm  ON pm.id_participacao = p.id_participacao_mandante
LEFT JOIN clube cm               ON cm.id_clube = pm.id_clube
LEFT JOIN participacao_clube pv  ON pv.id_participacao = p.id_participacao_visitante
LEFT JOIN clube cv               ON cv.id_clube = pv.id_clube
LEFT JOIN estadio es             ON es.id_estadio = p.id_estadio
LEFT JOIN sumula s               ON s.id_partida = p.id_partida
ORDER BY f.ordem ASC, r.numero ASC, p.data_hora ASC;
