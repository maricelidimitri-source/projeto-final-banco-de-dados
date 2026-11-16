-- =====================================================================
-- Catarinão em Dados — script_ddl.sql
-- Criação das 15 tabelas do cenário (SQLite)
-- =====================================================================

PRAGMA foreign_keys = ON;

-- ---------------------------------------------------------------------
-- NÍVEL 1 — tabelas sem FK
-- ---------------------------------------------------------------------

-- 1. Competição: a edição do campeonato
CREATE TABLE competicao (
    id_competicao INTEGER PRIMARY KEY,
    ano           INTEGER NOT NULL UNIQUE CHECK (ano >= 1924),
    data_inicio   TEXT    NOT NULL,
    data_fim      TEXT,
    regulamento   TEXT,
    status        TEXT    NOT NULL DEFAULT 'PLANEJADA'
                  CHECK (status IN ('PLANEJADA','EM_ANDAMENTO','ENCERRADA')),
    CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

-- 2. Clube: dados gerais de cada clube
CREATE TABLE clube (
    id_clube INTEGER PRIMARY KEY,
    nome     TEXT NOT NULL UNIQUE,
    cidade   TEXT NOT NULL,
    sigla    TEXT NOT NULL UNIQUE CHECK (length(sigla) BETWEEN 2 AND 5)
);

-- 4. Atleta: dados pessoais do jogador
CREATE TABLE atleta (
    id_atleta       INTEGER PRIMARY KEY,
    nome            TEXT NOT NULL,
    data_nascimento TEXT NOT NULL,
    nacionalidade   TEXT NOT NULL DEFAULT 'Brasileira'
);

-- 6. Profissional da comissão técnica
CREATE TABLE profissional_comissao (
    id_profissional     INTEGER PRIMARY KEY,
    nome                TEXT NOT NULL,
    funcao_profissional TEXT NOT NULL
                        CHECK (funcao_profissional IN ('TREINADOR','AUXILIAR','PREPARADOR_FISICO','TREINADOR_GOLEIROS','MEDICO','FISIOTERAPEUTA')),
    registro            TEXT UNIQUE          -- opcional (pode ficar NULL)
);

-- 8. Estádio
CREATE TABLE estadio (
    id_estadio INTEGER PRIMARY KEY,
    nome       TEXT    NOT NULL UNIQUE,
    cidade     TEXT    NOT NULL,
    capacidade INTEGER NOT NULL CHECK (capacidade > 0)
);

-- 12. Árbitro
CREATE TABLE arbitro (
    id_arbitro INTEGER PRIMARY KEY,
    nome       TEXT NOT NULL,
    associacao TEXT NOT NULL DEFAULT 'FCF',
    registro   TEXT NOT NULL UNIQUE
);

-- ---------------------------------------------------------------------
-- NÍVEL 2
-- ---------------------------------------------------------------------

-- 3. Participação do clube na edição (liga COMPETICAO + CLUBE)
CREATE TABLE participacao_clube (
    id_participacao INTEGER PRIMARY KEY,
    id_competicao   INTEGER NOT NULL,
    id_clube        INTEGER NOT NULL,
    data_inscricao  TEXT    NOT NULL,
    status          TEXT    NOT NULL DEFAULT 'CONFIRMADA'
                    CHECK (status IN ('PENDENTE','CONFIRMADA','DESCLASSIFICADA')),
    UNIQUE (id_competicao, id_clube),                     -- regra 2
    FOREIGN KEY (id_competicao) REFERENCES competicao(id_competicao)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_clube) REFERENCES clube(id_clube)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 9. Fase (pertence a uma competição)
CREATE TABLE fase (
    id_fase       INTEGER PRIMARY KEY,
    id_competicao INTEGER NOT NULL,
    nome          TEXT    NOT NULL,
    ordem         INTEGER NOT NULL CHECK (ordem > 0),
    UNIQUE (id_competicao, ordem),
    FOREIGN KEY (id_competicao) REFERENCES competicao(id_competicao)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ---------------------------------------------------------------------
-- NÍVEL 3
-- ---------------------------------------------------------------------

-- 10. Rodada (pertence a uma fase)
CREATE TABLE rodada (
    id_rodada INTEGER PRIMARY KEY,
    id_fase   INTEGER NOT NULL,
    numero    INTEGER NOT NULL CHECK (numero > 0),
    UNIQUE (id_fase, numero),
    FOREIGN KEY (id_fase) REFERENCES fase(id_fase)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. Inscrição do atleta (liga ATLETA + PARTICIPACAO_CLUBE)
CREATE TABLE inscricao_atleta (
    id_inscricao_atleta INTEGER PRIMARY KEY,
    id_atleta           INTEGER NOT NULL,
    id_participacao     INTEGER NOT NULL,
    numero_camisa       INTEGER NOT NULL CHECK (numero_camisa BETWEEN 1 AND 99),
    posicao             TEXT    NOT NULL
                        CHECK (posicao IN ('GOLEIRO','ZAGUEIRO','LATERAL','VOLANTE','MEIA','ATACANTE')),
    status              TEXT    NOT NULL DEFAULT 'ATIVA'
                        CHECK (status IN ('ATIVA','SUSPENSA','CANCELADA')),
    UNIQUE (id_participacao, numero_camisa),   -- dois atletas do mesmo clube não usam o mesmo número
    FOREIGN KEY (id_atleta) REFERENCES atleta(id_atleta)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_participacao) REFERENCES participacao_clube(id_participacao)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. Vínculo da comissão técnica (liga PROFISSIONAL + PARTICIPACAO_CLUBE)
CREATE TABLE vinculo_comissao (
    id_vinculo      INTEGER PRIMARY KEY,
    id_profissional INTEGER NOT NULL,
    id_participacao INTEGER NOT NULL,
    funcao          TEXT    NOT NULL,
    data_inicio     TEXT    NOT NULL,
    data_fim        TEXT,                                  -- NULL = ainda no cargo
    CHECK (data_fim IS NULL OR data_fim >= data_inicio),
    FOREIGN KEY (id_profissional) REFERENCES profissional_comissao(id_profissional)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_participacao) REFERENCES participacao_clube(id_participacao)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ---------------------------------------------------------------------
-- NÍVEL 4
-- ---------------------------------------------------------------------

-- 11. Partida
CREATE TABLE partida (
    id_partida                INTEGER PRIMARY KEY,
    id_rodada                 INTEGER NOT NULL,
    id_estadio                INTEGER NOT NULL,
    id_participacao_mandante  INTEGER NOT NULL,
    id_participacao_visitante INTEGER NOT NULL,
    data_hora                 TEXT    NOT NULL,           -- 'AAAA-MM-DD HH:MM'
    gols_mandante             INTEGER CHECK (gols_mandante >= 0),
    gols_visitante            INTEGER CHECK (gols_visitante >= 0),
    status                    TEXT    NOT NULL DEFAULT 'AGENDADA'
                              CHECK (status IN ('AGENDADA','FINALIZADA','ADIADA','CANCELADA')),
    CHECK (id_participacao_mandante <> id_participacao_visitante),          -- regra 11
    CHECK (status <> 'FINALIZADA'
           OR (gols_mandante IS NOT NULL AND gols_visitante IS NOT NULL)),  -- finalizada tem placar
    UNIQUE (id_estadio, data_hora),                                         -- regra 14
    FOREIGN KEY (id_rodada) REFERENCES rodada(id_rodada)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_estadio) REFERENCES estadio(id_estadio)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_participacao_mandante) REFERENCES participacao_clube(id_participacao)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_participacao_visitante) REFERENCES participacao_clube(id_participacao)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ---------------------------------------------------------------------
-- NÍVEL 5
-- ---------------------------------------------------------------------

-- 13. Escala de arbitragem (liga PARTIDA + ARBITRO)
CREATE TABLE escala_arbitragem (
    id_escala         INTEGER PRIMARY KEY,
    id_partida        INTEGER NOT NULL,
    id_arbitro        INTEGER NOT NULL,
    funcao_na_partida TEXT    NOT NULL
                      CHECK (funcao_na_partida IN ('PRINCIPAL','ASSISTENTE_1','ASSISTENTE_2','QUARTO_ARBITRO','VAR')),
    UNIQUE (id_partida, id_arbitro),          -- o árbitro aparece uma vez por jogo
    UNIQUE (id_partida, funcao_na_partida),   -- cada função tem um só árbitro no jogo
    FOREIGN KEY (id_partida) REFERENCES partida(id_partida)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_arbitro) REFERENCES arbitro(id_arbitro)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 14. Súmula (uma por partida)
CREATE TABLE sumula (
    id_sumula      INTEGER PRIMARY KEY,
    id_partida     INTEGER NOT NULL UNIQUE,   -- UNIQUE = relação 1 para 1 (regra 18)
    data_validacao TEXT,                      -- NULL enquanto não validada
    status         TEXT    NOT NULL DEFAULT 'PENDENTE'
                   CHECK (status IN ('PENDENTE','VALIDADA','RETIFICADA')),
    observacoes    TEXT,
    CHECK (status = 'PENDENTE' OR data_validacao IS NOT NULL),
    FOREIGN KEY (id_partida) REFERENCES partida(id_partida)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 15. Evento da partida (gols, cartões, substituições)
CREATE TABLE evento_partida (
    id_evento   INTEGER PRIMARY KEY,
    id_partida  INTEGER NOT NULL,
    id_atleta   INTEGER,                      -- opcional (regra 20: autor "quando conhecido")
    tipo_evento TEXT    NOT NULL
                CHECK (tipo_evento IN ('GOL','GOL_CONTRA','CARTAO_AMARELO','CARTAO_VERMELHO','SUBSTITUICAO')),
    minuto      INTEGER NOT NULL CHECK (minuto BETWEEN 0 AND 130),
    descricao   TEXT,
    FOREIGN KEY (id_partida) REFERENCES partida(id_partida)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_atleta) REFERENCES atleta(id_atleta)
        ON DELETE SET NULL ON UPDATE CASCADE
);
