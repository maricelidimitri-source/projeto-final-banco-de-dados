-- =====================================================================
-- Catarinão em Dados — script_dml.sql
-- Inserção de dados (simulados) para todas as tabelas
-- Rodar DEPOIS do script_ddl.sql, na ordem abaixo (pai antes do filho)
-- =====================================================================

PRAGMA foreign_keys = ON;

-- ---------------------------------------------------------------------
-- NÍVEL 1
-- ---------------------------------------------------------------------

INSERT INTO competicao (id_competicao, ano, data_inicio, data_fim, regulamento, status) VALUES
(1, 2026, '2026-01-17', '2026-04-05',
 'Primeira fase em turno único com 8 clubes; os 4 melhores vão à semifinal. Vitória = 3 pontos, empate = 1. Desempate: vitórias, saldo de gols, gols marcados.',
 'EM_ANDAMENTO');

INSERT INTO clube (id_clube, nome, cidade, sigla) VALUES
(1, 'Avaí Futebol Clube',               'Florianópolis',      'AVA'),
(2, 'Figueirense Futebol Clube',        'Florianópolis',      'FIG'),
(3, 'Associação Chapecoense de Futebol','Chapecó',            'CHA'),
(4, 'Criciúma Esporte Clube',           'Criciúma',           'CRI'),
(5, 'Joinville Esporte Clube',          'Joinville',          'JEC'),
(6, 'Brusque Futebol Clube',            'Brusque',            'BRU'),
(7, 'Clube Náutico Marcílio Dias',      'Itajaí',             'CNMD'),
(8, 'Barra Futebol Clube',              'Balneário Camboriú', 'BAR');

INSERT INTO atleta (id_atleta, nome, data_nascimento, nacionalidade) VALUES
(1,  'Lucas Ferreira',     '1997-03-12', 'Brasileira'),
(2,  'Gabriel Souza',      '1999-07-08', 'Brasileira'),
(3,  'Rafael Lima',        '1995-11-23', 'Brasileira'),
(4,  'Mateus Rocha',       '1998-01-30', 'Brasileira'),
(5,  'Diego Martins',      '2000-05-14', 'Brasileira'),
(6,  'Thiago Alves',       '1996-09-02', 'Brasileira'),
(7,  'Bruno Cardoso',      '1997-12-19', 'Brasileira'),
(8,  'Felipe Moraes',      '2001-04-05', 'Brasileira'),
(9,  'André Ribeiro',      '1994-08-27', 'Brasileira'),
(10, 'Juan Pablo Ortiz',   '1996-02-11', 'Uruguaia'),
(11, 'Vinícius Teixeira',  '1999-10-03', 'Brasileira'),
(12, 'Eduardo Pires',      '1995-06-21', 'Brasileira'),
(13, 'Caio Mendes',        '1998-03-16', 'Brasileira'),
(14, 'Leonardo Batista',   '2002-01-09', 'Brasileira'),
(15, 'Marcelo Duarte',     '1993-12-01', 'Brasileira'),
(16, 'Henrique Castro',    '1997-07-25', 'Brasileira'),
(17, 'Gustavo Nunes',      '2000-11-18', 'Brasileira'),
(18, 'Rodrigo Farias',     '1996-04-29', 'Brasileira'),
(19, 'Matías Fernández',   '1995-09-13', 'Argentina'),
(20, 'Pedro Henrique Dias','2001-02-07', 'Brasileira'),
(21, 'Fábio Correia',      '1994-05-30', 'Brasileira'),
(22, 'Igor Santana',       '1998-08-15', 'Brasileira'),
(23, 'Renan Vieira',       '2003-03-22', 'Brasileira'),
(24, 'Paulo Henrique Reis','1997-10-10', 'Brasileira'),
(25, 'Samuel Antunes',     '2004-06-06', 'Brasileira');  -- sem inscrição (atleta livre)

INSERT INTO profissional_comissao (id_profissional, nome, funcao_profissional, registro) VALUES
(1,  'Carlos Eduardo Brandão', 'TREINADOR',         'CBF-T-1001'),
(2,  'Márcio Goulart',         'TREINADOR',         'CBF-T-1002'),
(3,  'Roberto Zanella',        'TREINADOR',         'CBF-T-1003'),
(4,  'Sérgio Pacheco',         'TREINADOR',         'CBF-T-1004'),
(5,  'Fernando Kuhn',          'TREINADOR',         'CBF-T-1005'),
(6,  'Alexandre Hoffmann',     'TREINADOR',         'CBF-T-1006'),
(7,  'Jorge Luiz Amaral',      'TREINADOR',         'CBF-T-1007'),
(8,  'Wagner Silveira',        'TREINADOR',         'CBF-T-1008'),
(9,  'Daniel Prates',          'AUXILIAR',          'CBF-A-2001'),
(10, 'Ricardo Bortolotto',     'AUXILIAR',          'CBF-A-2002'),
(11, 'Luís Fernando Melo',     'PREPARADOR_FISICO', NULL),          -- sem registro
(12, 'Anderson Weber',         'TREINADOR',         'CBF-T-1009');

INSERT INTO estadio (id_estadio, nome, cidade, capacidade) VALUES   -- capacidades aproximadas
(1, 'Estádio da Ressacada',          'Florianópolis', 17800),
(2, 'Estádio Orlando Scarpelli',     'Florianópolis', 19500),
(3, 'Arena Condá',                   'Chapecó',       20000),
(4, 'Estádio Heriberto Hülse',       'Criciúma',      19000),
(5, 'Arena Joinville',               'Joinville',     22000),
(6, 'Estádio Augusto Bauer',         'Brusque',        5000),
(7, 'Estádio Gigantão das Avenidas', 'Itajaí',         8000);

INSERT INTO arbitro (id_arbitro, nome, associacao, registro) VALUES
(1, 'Bráulio da Silva Machado', 'FCF', 'FCF-001'),
(2, 'Ramon Abatti Abel',        'FCF', 'FCF-002'),
(3, 'Hélio Costa Júnior',       'FCF', 'FCF-003'),
(4, 'Juliana Spieker',          'FCF', 'FCF-004'),
(5, 'Diego Antunes Rosa',       'FCF', 'FCF-005'),
(6, 'Fernanda Kruger',          'FCF', 'FCF-006');

-- ---------------------------------------------------------------------
-- NÍVEL 2
-- ---------------------------------------------------------------------

-- Para facilitar, o id da participação é igual ao id do clube
INSERT INTO participacao_clube (id_participacao, id_competicao, id_clube, data_inscricao, status) VALUES
(1, 1, 1, '2025-11-10', 'CONFIRMADA'),
(2, 1, 2, '2025-11-10', 'CONFIRMADA'),
(3, 1, 3, '2025-11-11', 'CONFIRMADA'),
(4, 1, 4, '2025-11-11', 'CONFIRMADA'),
(5, 1, 5, '2025-11-12', 'CONFIRMADA'),
(6, 1, 6, '2025-11-12', 'CONFIRMADA'),
(7, 1, 7, '2025-11-13', 'CONFIRMADA'),
(8, 1, 8, '2025-11-14', 'CONFIRMADA');

INSERT INTO fase (id_fase, id_competicao, nome, ordem) VALUES
(1, 1, 'Primeira Fase', 1),
(2, 1, 'Semifinal',     2),
(3, 1, 'Final',         3);

-- ---------------------------------------------------------------------
-- NÍVEL 3
-- ---------------------------------------------------------------------

INSERT INTO rodada (id_rodada, id_fase, numero) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 1);   -- semifinal ainda sem partidas

-- Cada clube tem 3 atletas: atacante (9), meia (10) e zagueiro (4)
INSERT INTO inscricao_atleta (id_inscricao_atleta, id_atleta, id_participacao, numero_camisa, posicao, status) VALUES
(1,  1,  1, 9,  'ATACANTE', 'ATIVA'),
(2,  2,  1, 10, 'MEIA',     'ATIVA'),
(3,  3,  1, 4,  'ZAGUEIRO', 'ATIVA'),
(4,  4,  2, 9,  'ATACANTE', 'ATIVA'),
(5,  5,  2, 10, 'MEIA',     'ATIVA'),
(6,  6,  2, 4,  'ZAGUEIRO', 'ATIVA'),
(7,  7,  3, 9,  'ATACANTE', 'ATIVA'),
(8,  8,  3, 10, 'MEIA',     'ATIVA'),
(9,  9,  3, 4,  'ZAGUEIRO', 'ATIVA'),
(10, 10, 4, 9,  'ATACANTE', 'ATIVA'),
(11, 11, 4, 10, 'MEIA',     'ATIVA'),
(12, 12, 4, 4,  'ZAGUEIRO', 'ATIVA'),
(13, 13, 5, 9,  'ATACANTE', 'ATIVA'),
(14, 14, 5, 10, 'MEIA',     'ATIVA'),
(15, 15, 5, 4,  'ZAGUEIRO', 'SUSPENSA'),   -- expulso na rodada 1
(16, 16, 6, 9,  'ATACANTE', 'ATIVA'),
(17, 17, 6, 10, 'MEIA',     'ATIVA'),
(18, 18, 6, 4,  'ZAGUEIRO', 'ATIVA'),
(19, 19, 7, 9,  'ATACANTE', 'ATIVA'),
(20, 20, 7, 10, 'MEIA',     'ATIVA'),
(21, 21, 7, 4,  'ZAGUEIRO', 'ATIVA'),
(22, 22, 8, 9,  'ATACANTE', 'ATIVA'),
(23, 23, 8, 10, 'MEIA',     'ATIVA'),
(24, 24, 8, 4,  'ZAGUEIRO', 'ATIVA');

INSERT INTO vinculo_comissao (id_vinculo, id_profissional, id_participacao, funcao, data_inicio, data_fim) VALUES
(1,  1,  1, 'Treinador',         '2025-12-01', NULL),
(2,  2,  2, 'Treinador',         '2025-12-01', NULL),
(3,  3,  3, 'Treinador',         '2025-12-01', NULL),
(4,  4,  4, 'Treinador',         '2025-12-01', NULL),
(5,  5,  5, 'Treinador',         '2025-12-01', NULL),
(6,  6,  6, 'Treinador',         '2025-12-01', NULL),
(7,  7,  7, 'Treinador',         '2025-12-01', NULL),
(8,  8,  8, 'Treinador',         '2025-12-01', '2026-01-23'),  -- demitido após a rodada 2
(9,  12, 8, 'Treinador',         '2026-01-24', NULL),          -- substituto
(10, 9,  1, 'Auxiliar técnico',  '2025-12-01', NULL),
(11, 10, 3, 'Auxiliar técnico',  '2025-12-01', NULL),
(12, 11, 5, 'Preparador físico', '2025-12-01', NULL);

-- ---------------------------------------------------------------------
-- NÍVEL 4
-- ---------------------------------------------------------------------

-- Partidas agendadas ficam com placar NULL
INSERT INTO partida (id_partida, id_rodada, id_estadio, id_participacao_mandante, id_participacao_visitante, data_hora, gols_mandante, gols_visitante, status) VALUES
-- Rodada 1
(1,  1, 1, 1, 2, '2026-01-17 16:00', 2, 1, 'FINALIZADA'),     -- AVA x FIG
(2,  1, 3, 3, 4, '2026-01-17 18:30', 1, 1, 'FINALIZADA'),     -- CHA x CRI
(3,  1, 5, 5, 6, '2026-01-18 16:00', 0, 2, 'FINALIZADA'),     -- JEC x BRU
(4,  1, 7, 7, 8, '2026-01-18 18:30', 3, 0, 'FINALIZADA'),     -- CNMD x BAR
-- Rodada 2
(5,  2, 2, 2, 3, '2026-01-21 19:30', 1, 0, 'FINALIZADA'),     -- FIG x CHA
(6,  2, 4, 4, 5, '2026-01-21 21:30', 2, 2, 'FINALIZADA'),     -- CRI x JEC
(7,  2, 6, 6, 7, '2026-01-22 19:30', 1, 0, 'FINALIZADA'),     -- BRU x CNMD
(8,  2, 7, 8, 1, '2026-01-22 21:30', 0, 3, 'FINALIZADA'),     -- BAR x AVA
-- Rodada 3
(9,  3, 1, 1, 3, '2026-01-25 16:00', 1, 0, 'FINALIZADA'),     -- AVA x CHA
(10, 3, 2, 2, 4, '2026-01-25 18:30', 0, 0, 'FINALIZADA'),     -- FIG x CRI
(11, 3, 5, 5, 7, '2026-02-01 16:00', NULL, NULL, 'AGENDADA'), -- JEC x CNMD
(12, 3, 6, 6, 8, '2026-02-01 18:30', NULL, NULL, 'AGENDADA'); -- BRU x BAR

-- ---------------------------------------------------------------------
-- NÍVEL 5
-- ---------------------------------------------------------------------

INSERT INTO escala_arbitragem (id_escala, id_partida, id_arbitro, funcao_na_partida) VALUES
(1,  1,  1, 'PRINCIPAL'), (2,  1,  2, 'ASSISTENTE_1'),
(3,  2,  3, 'PRINCIPAL'), (4,  2,  4, 'ASSISTENTE_1'),
(5,  3,  5, 'PRINCIPAL'), (6,  3,  6, 'ASSISTENTE_1'),
(7,  4,  1, 'PRINCIPAL'), (8,  4,  2, 'ASSISTENTE_1'),
(9,  5,  3, 'PRINCIPAL'), (10, 5,  4, 'ASSISTENTE_1'),
(11, 6,  5, 'PRINCIPAL'), (12, 6,  6, 'ASSISTENTE_1'),
(13, 7,  1, 'PRINCIPAL'), (14, 7,  2, 'ASSISTENTE_1'),
(15, 8,  3, 'PRINCIPAL'), (16, 8,  4, 'ASSISTENTE_1'),
(17, 9,  5, 'PRINCIPAL'), (18, 9,  6, 'ASSISTENTE_1'),
(19, 10, 1, 'PRINCIPAL'), (20, 10, 2, 'ASSISTENTE_1'),
(21, 11, 3, 'PRINCIPAL'),
(22, 12, 5, 'PRINCIPAL');

-- Partidas agendadas (11 e 12) ainda não têm súmula
INSERT INTO sumula (id_sumula, id_partida, data_validacao, status, observacoes) VALUES
(1,  1,  '2026-01-18', 'VALIDADA',   NULL),
(2,  2,  '2026-01-18', 'VALIDADA',   NULL),
(3,  3,  '2026-01-19', 'VALIDADA',   'Expulsão do zagueiro do Joinville aos 85 minutos.'),
(4,  4,  '2026-01-19', 'VALIDADA',   NULL),
(5,  5,  '2026-01-22', 'VALIDADA',   NULL),
(6,  6,  '2026-01-22', 'VALIDADA',   NULL),
(7,  7,  '2026-01-23', 'VALIDADA',   'Expulsão do zagueiro do Marcílio Dias aos 75 minutos.'),
(8,  8,  '2026-01-24', 'RETIFICADA', 'Autoria do terceiro gol corrigida após análise do vídeo.'),
(9,  9,  '2026-01-26', 'VALIDADA',   NULL),
(10, 10, NULL,         'PENDENTE',   'Aguardando assinatura do árbitro.');

-- Gols batem com o placar de cada partida (GOL_CONTRA conta para o adversário)
INSERT INTO evento_partida (id_evento, id_partida, id_atleta, tipo_evento, minuto, descricao) VALUES
-- Partida 1: AVA 2 x 1 FIG
(1,  1, 1,  'GOL',             12, NULL),
(2,  1, 6,  'CARTAO_AMARELO',  30, 'Falta tática'),
(3,  1, 4,  'GOL',             40, NULL),
(4,  1, 3,  'CARTAO_AMARELO',  55, 'Reclamação'),
(5,  1, 2,  'GOL',             67, 'Cobrança de falta'),
-- Partida 2: CHA 1 x 1 CRI
(6,  2, 7,  'GOL',             20, NULL),
(7,  2, 9,  'CARTAO_AMARELO',  50, NULL),
(8,  2, 10, 'GOL',             78, 'Cabeceio'),
-- Partida 3: JEC 0 x 2 BRU
(9,  3, 16, 'GOL',             35, NULL),
(10, 3, 13, 'CARTAO_AMARELO',  44, NULL),
(11, 3, 15, 'GOL_CONTRA',      60, 'Desvio após cruzamento'),
(12, 3, 15, 'CARTAO_VERMELHO', 85, 'Entrada violenta'),
-- Partida 4: CNMD 3 x 0 BAR
(13, 4, 19, 'GOL',             10, NULL),
(14, 4, 24, 'CARTAO_AMARELO',  33, NULL),
(15, 4, 19, 'GOL',             44, 'Pênalti'),
(16, 4, 21, 'SUBSTITUICAO',    60, 'Saiu por lesão'),
(17, 4, 20, 'GOL',             70, NULL),
-- Partida 5: FIG 1 x 0 CHA
(18, 5, 8,  'CARTAO_AMARELO',  25, NULL),
(19, 5, 5,  'GOL',             88, NULL),
-- Partida 6: CRI 2 x 2 JEC
(20, 6, 10, 'GOL',              5, NULL),
(21, 6, 13, 'GOL',             30, NULL),
(22, 6, 12, 'CARTAO_AMARELO',  41, NULL),
(23, 6, 11, 'GOL',             50, NULL),
(24, 6, 14, 'CARTAO_AMARELO',  72, NULL),
(25, 6, 14, 'GOL',             90, 'Nos acréscimos'),
-- Partida 7: BRU 1 x 0 CNMD
(26, 7, 17, 'GOL',             63, NULL),
(27, 7, 21, 'CARTAO_VERMELHO', 75, NULL),
-- Partida 8: BAR 0 x 3 AVA
(28, 8, 1,  'GOL',             22, NULL),
(29, 8, 22, 'CARTAO_AMARELO',  40, NULL),
(30, 8, 1,  'GOL',             58, NULL),
(31, 8, 2,  'GOL',             81, 'Autoria corrigida na retificação da súmula'),
-- Partida 9: AVA 1 x 0 CHA
(32, 9, 7,  'CARTAO_AMARELO',  38, NULL),
(33, 9, 3,  'GOL',             45, 'Cabeceio após escanteio'),
-- Partida 10: FIG 0 x 0 CRI
(34, 10, 4,  'CARTAO_AMARELO', 15, NULL),
(35, 10, 11, 'CARTAO_AMARELO', 66, NULL);
