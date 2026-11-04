SELECT 
    m.especialidade,
    SUM(c.valor_consulta) AS faturamento_total
FROM consultas c
JOIN medicos m ON c.id_medico = m.id_medico
WHERE m.especialidade LIKE '%Cirurgia%'
GROUP BY m.especialidade
ORDER BY faturamento_total DESC;