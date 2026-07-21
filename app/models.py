from sqlalchemy import Column, Integer, String, ForeignKey, Numeric
from sqlalchemy.orm import relationship
from .database import Base

# ==========================================
# 1. GRADE E DISCIPLINAS
# ==========================================

class Disciplina(Base):
    __tablename__ = "DISCIPLINA"

    codigo_disciplina = Column(String, primary_key=True, index=True)
    nome_disciplina = Column(String)
    nivel_semestre = Column(Integer)
    eixo_tematico = Column(String)
    carga_horaria = Column(Integer)

class PreRequisito(Base):
    __tablename__ = "PRE_REQUISITO"

    disciplina_alvo = Column(String, ForeignKey("DISCIPLINA.codigo_disciplina"), primary_key=True)
    disciplina_requisito = Column(String, ForeignKey("DISCIPLINA.codigo_disciplina"), primary_key=True)

class Curso(Base):
    __tablename__ = "CURSO"

    sigla_curso = Column(String, primary_key=True, index=True)
    nome_curso = Column(String)

class CursoDisciplina(Base):
    __tablename__ = "CURSO_DISCIPLINA"

    sigla_curso = Column(String, ForeignKey("CURSO.sigla_curso"), primary_key=True)
    codigo_disciplina = Column(String, ForeignKey("DISCIPLINA.codigo_disciplina"), primary_key=True)


# ==========================================
# 2. DOCENTES E ALOCAÇÃO
# ==========================================

class Professor(Base):
    __tablename__ = "PROFESSOR"

    id_docente = Column(Integer, primary_key=True, index=True)
    nome_docente = Column(String)
    carga_horaria_total = Column(Integer)

class HistoricoMinistrante(Base):
    __tablename__ = "HISTORICO_MINISTRANTE"

    id_docente = Column(Integer, ForeignKey("PROFESSOR.id_docente"), primary_key=True)
    codigo_disciplina = Column(String, ForeignKey("DISCIPLINA.codigo_disciplina"), primary_key=True)


# ==========================================
# 3. TURMAS E HORÁRIOS
# ==========================================

class Turma(Base):
    __tablename__ = "TURMA"

    id_turma = Column(Integer, primary_key=True, index=True)
    codigo_disciplina = Column(String, ForeignKey("DISCIPLINA.codigo_disciplina"))
    id_docente = Column(Integer, ForeignKey("PROFESSOR.id_docente"))
    semestre_letivo = Column(String)
    modulo = Column(Integer)

class HorarioTurma(Base):
    __tablename__ = "HORARIO_TURMA"

    id_turma = Column(Integer, ForeignKey("TURMA.id_turma"), primary_key=True)
    dia_semana = Column(Integer, primary_key=True)
    bloco_horario = Column(String, primary_key=True)


# ==========================================
# 4. ALUNOS E HISTÓRICO ACADÊMICO
# ==========================================

class Aluno(Base):
    __tablename__ = "ALUNO"

    id_anonimo = Column(Integer, primary_key=True, index=True)
    matricula = Column(String)
    nome_aluno = Column(String)
    semestre_ingresso = Column(String)
    status_matricula = Column(String)

class HistoricoAluno(Base):
    __tablename__ = "HISTORICO_ALUNO"

    id_anonimo = Column(Integer, ForeignKey("ALUNO.id_anonimo"), primary_key=True)
    codigo_disciplina = Column(String, ForeignKey("DISCIPLINA.codigo_disciplina"), primary_key=True)
    semestre_cursado = Column(String, primary_key=True)
    nota_final = Column(Numeric)  # Numeric é o correspondente no SQLAlchemy para Decimal
    situacao = Column(String)