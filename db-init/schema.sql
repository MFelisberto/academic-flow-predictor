-- ==========================================
-- 1. CRIAÇÃO DAS TABELAS E ESTRUTURAS (DDL)
-- ==========================================

CREATE TABLE "DISCIPLINA" (
  "codigo_disciplina" varchar PRIMARY KEY,
  "nome_disciplina" varchar,
  "nivel_semestre" int,
  "eixo_tematico" varchar
);

CREATE TABLE "PRE_REQUISITO" (
  "disciplina_alvo" varchar,
  "disciplina_requisito" varchar,
  PRIMARY KEY ("disciplina_alvo", "disciplina_requisito")
);

CREATE TABLE "PROFESSOR" (
  "id_docente" int PRIMARY KEY,
  "nome_docente" varchar,
  "carga_horaria_total" int
);

CREATE TABLE "COMPETENCIA" (
  "id_docente" int,
  "codigo_disciplina" varchar,
  PRIMARY KEY ("id_docente", "codigo_disciplina")
);

CREATE TABLE "TURMA" (
  "id_turma" int PRIMARY KEY,
  "codigo_disciplina" varchar,
  "id_docente" int,
  "semestre_letivo" varchar,
  "modulo" varchar,
  "capacidade_maxima" int
);

CREATE TABLE "HORARIO_TURMA" (
  "id_turma" int,
  "dia_semana" int,
  "bloco_horario" varchar,
  PRIMARY KEY ("id_turma", "dia_semana", "bloco_horario")
);

CREATE TABLE "ALUNO" (
  "id_anonimo" int PRIMARY KEY,
  "matricula" varchar,
  "nome_aluno" varchar,
  "semestre_ingresso" varchar,
  "status_matricula" varchar
);

CREATE TABLE "HISTORICO_ALUNO" (
  "id_anonimo" int,
  "codigo_disciplina" varchar,
  "semestre_cursado" varchar,
  "nota_final" decimal,
  "situacao" varchar,
  PRIMARY KEY ("id_anonimo", "codigo_disciplina", "semestre_cursado")
);

CREATE TABLE "CURSO" (
  "sigla_curso" varchar PRIMARY KEY,
  "nome_curso" varchar
);

CREATE TABLE "CURSO_DISCIPLINA" (
  "sigla_curso" varchar,
  "codigo_disciplina" varchar,
  PRIMARY KEY ("sigla_curso", "codigo_disciplina")
);

-- ==========================================
-- 2. CRIAÇÃO DOS RELACIONAMENTOS (FOREIGN KEYS)
-- ==========================================

ALTER TABLE "PRE_REQUISITO" ADD FOREIGN KEY ("disciplina_alvo") REFERENCES "DISCIPLINA" ("codigo_disciplina") DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "PRE_REQUISITO" ADD FOREIGN KEY ("disciplina_requisito") REFERENCES "DISCIPLINA" ("codigo_disciplina") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "COMPETENCIA" ADD FOREIGN KEY ("id_docente") REFERENCES "PROFESSOR" ("id_docente") DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "COMPETENCIA" ADD FOREIGN KEY ("codigo_disciplina") REFERENCES "DISCIPLINA" ("codigo_disciplina") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "TURMA" ADD FOREIGN KEY ("codigo_disciplina") REFERENCES "DISCIPLINA" ("codigo_disciplina") DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "TURMA" ADD FOREIGN KEY ("id_docente") REFERENCES "PROFESSOR" ("id_docente") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "HORARIO_TURMA" ADD FOREIGN KEY ("id_turma") REFERENCES "TURMA" ("id_turma") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "HISTORICO_ALUNO" ADD FOREIGN KEY ("id_anonimo") REFERENCES "ALUNO" ("id_anonimo") DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "HISTORICO_ALUNO" ADD FOREIGN KEY ("codigo_disciplina") REFERENCES "DISCIPLINA" ("codigo_disciplina") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "CURSO_DISCIPLINA" ADD FOREIGN KEY ("sigla_curso") REFERENCES "CURSO" ("sigla_curso") DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "CURSO_DISCIPLINA" ADD FOREIGN KEY ("codigo_disciplina") REFERENCES "DISCIPLINA" ("codigo_disciplina") DEFERRABLE INITIALLY IMMEDIATE;

-- ==========================================
-- 3. INSERÇÃO DE DADOS (DML) - GRADE 98AJ
-- ==========================================

-- Inserindo o Curso Base
INSERT INTO "CURSO" ("sigla_curso", "nome_curso") VALUES 
('98AJ', 'Ciência da Computação');

-- Inserindo as Disciplinas e categorizando os eixos temáticos correspondentes
INSERT INTO "DISCIPLINA" ("codigo_disciplina", "nome_disciplina", "nivel_semestre", "eixo_tematico") VALUES
-- Nível 1
('95303-04', 'Matemática Discreta', 1, 'Lógica e Estruturas Discretas'),
('98707-02', 'Metodologia Científica', 1, 'Metodologia e Integração'),
('4611C-06', 'Fundamentos de Programação', 1, 'Algoritmos e Programação'),
('1501A-04', 'Ética e Cidadania', 1, 'Contexto Profissional e Social'),
('98705-02', 'Introdução à Computação', 1, 'Infraestrutura de Sistemas'),
('95300-04', 'Cálculo I', 1, 'Matemática na Computação'),

-- Nível 2
('4611E-04', 'Lógica para Computação', 2, 'Lógica e Estruturas Discretas'),
('4611F-04', 'Programação Orientada a Objetos', 2, 'Algoritmos e Programação'),
('4645G-04', 'Algoritmos e Estruturas de Dados I', 2, 'Algoritmos e Programação'),
('98901-04', 'Banco de Dados I', 2, 'Infraestrutura de Sistemas'),
('4646B-04', 'Fundamentos de Sistemas Digitais', 2, 'Infraestrutura de Sistemas'),
('95301-04', 'Cálculo II', 2, 'Matemática na Computação'),
('980E8-24', 'Disciplinas Eletivas', 2, 'Eletivas'),

-- Nível 3
('46515-04', 'Linguagens, Autômatos e Computação', 3, 'Lógica e Estruturas Discretas'),
('98702-04', 'Prática em Pesquisa', 3, 'Metodologia e Integração'),
('4645H-04', 'Algoritmos e Estruturas de Dados II', 3, 'Algoritmos e Programação'),
('98902-02', 'Banco de Dados II', 3, 'Infraestrutura de Sistemas'),
('98701-04', 'Programação de Baixo Nível', 3, 'Algoritmos e Programação'),
('98G03-04', 'Organização e Arquitetura de Processadores', 3, 'Infraestrutura de Sistemas'),
('95304-04', 'Probabilidade e Estatística', 3, 'Matemática na Computação'),

-- Nível 4
('98703-02', 'Programação Funcional', 4, 'Aplicações Avançadas'),
('98713-04', 'Fundamentos de Proc. Paralelo e Distribuído', 4, 'Computação Distribuída e em Rede'),
('4636H-04', 'Fundamentos de Desenvolvimento de Software', 4, 'Espec. e Construção de Sistemas'),
('98801-04', 'Engenharia de Software I', 4, 'Espec. e Construção de Sistemas'),
('98H00-04', 'Infraestrutura para Gestão de Dados', 4, 'Infraestrutura de Sistemas'),
('98716-04', 'Computação Gráfica', 4, 'Aplicações Avançadas'),
('95302-04', 'Álgebra Linear e Geometria Analítica', 4, 'Matemática na Computação'),

-- Nível 5
('4647F-04', 'Teoria da Computabilidade e Complexidade', 5, 'Lógica e Estruturas Discretas'),
('98802-02', 'Engenharia de Software II', 5, 'Espec. e Construção de Sistemas'),
('98905-04', 'Experiência do Usuário', 5, 'Aplicações Avançadas'),
('4646Z-04', 'Projeto e Otimização de Algoritmos', 5, 'Algoritmos e Programação'),
('4646X-04', 'Projeto de Desenvolvimento de Jogos', 5, 'Aplicações Avançadas'),
('98700-04', 'Sistemas Operacionais', 5, 'Infraestrutura de Sistemas'),
('4646N-04', 'Métodos Numéricos', 5, 'Aplicações Avançadas'),

-- Nível 6
('4646M-04', 'Métodos Formais', 6, 'Espec. e Construção de Sistemas'),
('98704-04', 'Prática em Engenharia de Software', 6, 'Metodologia e Integração'),
('98708-04', 'Inteligência Artificial', 6, 'Aplicações Avançadas'),
('98709-04', 'Fundamentos de Redes de Computadores', 6, 'Computação Distribuída e em Rede'),
('98710-02', 'Laboratório de Redes de Computadores', 6, 'Computação Distribuída e em Rede'),
('4646I-04', 'Laboratório de Sistemas Operacionais', 6, 'Infraestrutura de Sistemas'),

-- Nível 7
('98711-02', 'Trabalho de Conclusão I', 7, 'Metodologia e Integração'),
('4645K-04', 'Construção de Compiladores', 7, 'Aplicações Avançadas'),
('98706-04', 'Aprendizado de Máquina', 7, 'Aplicações Avançadas'),
('4647A-04', 'Redes de Computadores Avançadas', 7, 'Computação Distribuída e em Rede'),
('4611G-04', 'Simulação e Métodos Analíticos', 7, 'Aplicações Avançadas'),

-- Nível 8
('98714-02', 'Trabalho de Conclusão II', 8, 'Metodologia e Integração'),
('11521-04', 'Humanismo e Cultura Religiosa', 8, 'Contexto Profissional e Social'),
('98715-04', 'Segurança de Sistemas', 8, 'Infraestrutura de Sistemas'),
('4647B-04', 'Sistemas Distribuídos', 8, 'Computação Distribuída e em Rede'),
('4645J-04', 'Computação Paralela', 8, 'Computação Distribuída e em Rede');

-- Vinculando TODAS as disciplinas inseridas ao curso 98AJ
INSERT INTO "CURSO_DISCIPLINA" ("sigla_curso", "codigo_disciplina")
SELECT '98AJ', "codigo_disciplina" FROM "DISCIPLINA";

-- Inserindo a malha de grafos (Pré-requisitos)
-- Lógica: (Disciplina_Alvo, Disciplina_Requisito)
INSERT INTO "PRE_REQUISITO" ("disciplina_alvo", "disciplina_requisito") VALUES
('4611E-04', '95303-04'),
('98702-04', '98707-02'),
('4611F-04', '4611C-06'),
('4645G-04', '4611C-06'),
('98701-04', '4611C-06'),
('95301-04', '95300-04'),
('95304-04', '95300-04'),
('4636H-04', '4611F-04'),
('98713-04', '4611F-04'),
('4645H-04', '4645G-04'),
('98902-02', '98901-04'),
('98G03-04', '4646B-04'),
('98701-04', '4646B-04'),
('4646M-04', '4611E-04'),
('98708-04', '4611E-04'),
('4646Z-04', '4645H-04'),
('98708-04', '4645H-04'),
('98H00-04', '98902-02'),
('98716-04', '98701-04'),
('4611G-04', '95304-04'),
('98802-02', '98801-04'),
('98905-04', '98801-04'),
('4646X-04', '98716-04'),
('4646N-04', '95302-04'),
('98715-04', '4646Z-04'),
('98709-04', '98700-04'),
('4646I-04', '98700-04'),
('98706-04', '98708-04'),
('4647A-04', '98709-04');