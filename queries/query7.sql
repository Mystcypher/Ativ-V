SELECT 
    p.nome_paciente,
    q.numero_quarto,
    i.valor_diaria
FROM internacoes i
JOIN pacientes p ON i.id_paciente = p.id_paciente
JOIN quartos q ON i.id_quarto = q.id_quarto
ORDER BY i.valor_diaria ASC;