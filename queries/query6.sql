SELECT 
    p.nome_paciente,
    m.nome_medico,
    c.data_consulta
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico
ORDER BY c.data_consulta DESC;