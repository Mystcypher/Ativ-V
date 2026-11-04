SELECT 
    m.nome_medico,
    m.especialidade,
    p.nome_paciente,
    pr.medicamento
FROM prescricoes pr
JOIN consultas c ON pr.id_consulta = c.id_consulta
JOIN medicos m ON c.id_medico = m.id_medico
JOIN pacientes p ON c.id_paciente = p.id_paciente;