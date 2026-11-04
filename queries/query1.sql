SELECT 
    p.nome_paciente,
    m.nome_medico,
    c.data_consulta,
    pr.medicamento,
    pr.quantidade
FROM prescricoes pr
JOIN consultas c ON pr.id_consulta = c.id_consulta
JOIN pacientes p ON c.id_paciente = p.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico;