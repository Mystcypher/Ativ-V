SELECT 
    p.nome_paciente,
    q.numero_quarto,
    q.andar,
    i.data_entrada,
    i.valor_diaria
FROM internacoes i
JOIN pacientes p ON i.id_paciente = p.id_paciente
JOIN quartos q ON i.id_quarto = q.id_quarto;