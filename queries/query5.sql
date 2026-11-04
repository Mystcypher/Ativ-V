SELECT DISTINCT
    p.nome_paciente,
    q.numero_quarto,
    m.nome_medico,
    c.data_consulta
FROM pacientes p
JOIN internacoes i ON p.id_paciente = i.id_paciente
JOIN quartos q ON i.id_quarto = q.id_quarto
JOIN consultas c ON p.id_paciente = c.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico;