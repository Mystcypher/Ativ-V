SELECT 
    p.nome_paciente,
    p.convenio,
    SUM(c.valor_consulta) AS total_investido
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
WHERE p.convenio LIKE '%Unimed%'
GROUP BY p.id_paciente, p.nome_paciente, p.convenio
ORDER BY total_investido DESC;