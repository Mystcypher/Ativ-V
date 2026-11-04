SELECT 
    q.andar,
    SUM(i.valor_diaria) AS custo_total_diarias
FROM internacoes i
JOIN pacientes p ON i.id_paciente = p.id_paciente
JOIN quartos q ON i.id_quarto = q.id_quarto
WHERE p.nome_paciente LIKE '%Oliveira%'
GROUP BY q.andar
ORDER BY q.andar ASC;