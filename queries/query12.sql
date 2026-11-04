SELECT 
    p.nome_paciente,
    q.numero_quarto,
    i.data_entrada
FROM internacoes i
JOIN pacientes p ON i.id_paciente = p.id_paciente
JOIN quartos q ON i.id_quarto = q.id_quarto
WHERE i.data_entrada BETWEEN '2026-01-01' AND '2026-06-30';