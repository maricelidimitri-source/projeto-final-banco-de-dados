--- Consulta 7: Árbitros que apitaram como PRINCIPAL alguma partida com cartão vermelho.
--- Para cada árbitro, a subconsulta com EXISTS verifica se existe ao menos uma partida
--- em que ele foi o árbitro principal e houve expulsão.
--- Recursos: subconsulta correlacionada com EXISTS, ORDER BY ASC.

SELECT a.nome, a.registro
FROM arbitro a
WHERE EXISTS (
    SELECT 1
    FROM escala_arbitragem ea
    INNER JOIN evento_partida e ON e.id_partida = ea.id_partida
    WHERE ea.id_arbitro = a.id_arbitro
      AND ea.funcao_na_partida = 'PRINCIPAL'
      AND e.tipo_evento = 'CARTAO_VERMELHO'
)
ORDER BY a.nome ASC;
