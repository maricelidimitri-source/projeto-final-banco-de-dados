--- Consulta 10: Validação da súmula pendente e tentativa de remarcação, usando transações.
--- Parte A: valida a súmula da partida 10 e marca um SAVEPOINT; em seguida tenta remarcar a partida 12,
---          mas a remarcação é cancelada com ROLLBACK TO. A validação é confirmada com COMMIT.
--- Parte B: tenta excluir todas as partidas agendadas, mas desiste e desfaz tudo com ROLLBACK.
--- Recursos: BEGIN TRANSACTION, SAVEPOINT, ROLLBACK TO, RELEASE, COMMIT e ROLLBACK.

-- ===== Parte A =====
BEGIN TRANSACTION;

UPDATE sumula
SET status = 'VALIDADA', data_validacao = '2026-01-27',
    observacoes = 'Assinada pelo árbitro em 27/01.'
WHERE id_partida = 10;

SAVEPOINT remarcacao;

UPDATE partida
SET data_hora = '2026-02-03 20:00', status = 'ADIADA'
WHERE id_partida = 12;

-- a organização desistiu da remarcação: desfaz só o que veio depois do savepoint
ROLLBACK TO remarcacao;
RELEASE remarcacao;

COMMIT;   -- confirma a validação da súmula

-- ===== Parte B =====
BEGIN TRANSACTION;

DELETE FROM partida WHERE status = 'AGENDADA';

ROLLBACK; -- desfaz a exclusão: nenhuma partida é apagada

-- conferência: súmula 10 validada e partida 12 com data original e ainda agendada
SELECT id_partida, status, data_validacao FROM sumula  WHERE id_partida = 10;
SELECT id_partida, data_hora, status      FROM partida WHERE id_partida IN (11, 12);
