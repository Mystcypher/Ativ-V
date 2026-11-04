SELECT 
    p.nome_paciente,
    p.convenio,
    m.nome_medico,
    m.especialidade
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico;