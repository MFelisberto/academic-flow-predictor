import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# Pega a URL do banco que declaramos no docker-compose (environment)
SQLALCHEMY_DATABASE_URL = os.getenv(
    "DATABASE_URL", 
    "postgresql://postgres:root@localhost:5432/tcc_98aj" # Fallback caso rode fora do Docker
)

# Cria o motor de conexão com o banco
engine = create_engine(SQLALCHEMY_DATABASE_URL)

# Cria a fábrica de sessões (cada requisição na API terá sua própria sessão)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base para criar os nossos modelos do banco de dados
Base = declarative_base()

# Função auxiliar para injetar a conexão com o banco nas rotas da API
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()