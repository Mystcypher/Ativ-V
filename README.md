# 🏥 Sistema de Gestão Hospitalar "Vida & Saúde"

---

## 📌 Sobre o Projeto

O **Hospital Geral Vida & Saúde** enfrentava graves gargalos operacionais devido ao uso de sistemas legados, folhas de papel e planilhas isoladas. A ausência de um sistema centralizado resultava em:
- **15% de cobranças incorretas** por falhas na auditoria;
- **8% de perda no histórico clínico** de doentes crónicos;
- **Cancelamento de dezenas de consultas** por sobreposição de agendas médicas.

Este projeto consiste no desenvolvimento da primeira versão do **Banco de Dados Relacional** centralizado da instituição, construído e testado no **MySQL Workbench**, normalizado até à **3ª Forma Normal (3FN)** para garantir a integridade dos dados e responder a consultas estratégicas em tempo real.

---

## 🛠️ Tecnologias Utilizadas

* **SGBD:** MySQL (v8.0+)
* **Ferramenta de Modelação / SQL:** MySQL Workbench
* **Versionamento:** Git & GitHub

---

## 📐 Estrutura do Banco de Dados (3FN)

O esquema foi estruturado para assegurar a integridade referencial com restrições (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`) e ações em cascata/restrição adequadas.

### Modelo de Entidades
1. **`pacientes`**: Registo completo dos utentes, dados de contacto e convénio/plano de saúde.
2. **`medicos`**: Registo dos profissionais de saúde, respetivo CRM e especialidade.
3. **`quartos`**: Controlo de leitos por andar, tipo (UTI, Enfermaria, Apartamento, Suíte VIP) e estado de ocupação.
4. **`internacoes`**: Histórico de internamentos por paciente e quarto, com registo de datas de entrada/saída e custos diários.
5. **`consultas`**: Agendamentos e atendimentos realizados entre médicos e pacientes.
6. **`prescricoes`**: Medicamentos, dosagens e quantidades receitadas durante as consultas.

---

## 📁 Estrutura do Repositório

```text
├── hospital_dump.sql     # Script SQL com DDL (criação de tabelas) e DML (massa de dados)
├── queries.sql           # Script SQL contendo as 15 consultas estratégicas (DQL)
└── README.md             # Documentação do projeto
