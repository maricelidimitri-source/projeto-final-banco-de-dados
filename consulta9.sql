--- Consulta 9: Registro do resultado da partida 11 (JEC x CNMD) usando transação.
--- Atualiza o placar, insere os eventos e a súmula de forma "tudo ou nada".
--- Um SAVEPOINT marca o ponto antes dos eventos: um gol lançado por engano (atleta errado)
--- é desfeito com ROLLBACK TO, o gol correto é inserido e tudo é confirmado com COMMIT.
--- Recursos: BEGIN TRANSACTION, SAVEPOINT, ROLLBACK TO, RELEASE, COMMIT.
--- ATENÇÃO: rode apenas uma vez (a súmula da partida 11 só pode existir uma vez).

BEGIN TRANSACTION;

UPDATE partida
SET gols_mandante = 1, gols_visitante = 1, status = 'FINALIZADA'
WHERE id_partida = 11;

SAVEPOINT eventos_partida_11;

-- ERRO de digitação: gol atribuído ao atleta 25, que nem está inscrito na competição
INSERT INTO evento_partida (id_evento, id_partida, id_atleta, tipo_evento, minuto, descricao)
VALUES (36, 11, 25, 'GOL', 15, NULL);

-- desfaz apenas o que veio depois do savepoint (o UPDATE do placar continua valendo)
ROLLBACK TO eventos_partida_11;

-- lançamentos corretos
INSERT INTO evento_partida (id_evento, id_partida, id_atleta, tipo_evento, minuto, descricao) VALUES
(36, 11, 14, 'GOL', 15, NULL),               -- Leonardo Batista (JEC)
(37, 11, 20, 'GOL', 77, NULL),               -- Pedro Henrique Dias (CNMD)
(38, 11, 13, 'CARTAO_AMARELO', 52, NULL);

RELEASE eventos_partida_11;

INSERT INTO sumula (id_sumula, id_partida, data_validacao, status, observacoes)
VALUES (11, 11, '2026-02-02', 'VALIDADA', NULL);

COMMIT;

-- conferência
SELECT id_partida, gols_mandante, gols_visitante, status FROM partida WHERE id_partida = 11;
SELECT * FROM evento_partida WHERE id_partida = 11;
