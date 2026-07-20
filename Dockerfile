# Usa uma imagem oficial e leve do Python
FROM python:3.11-slim

# Define o diretório de trabalho raiz do projeto dentro do contêiner
WORKDIR /code

# Instala as dependências do sistema necessárias para o banco
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copia o arquivo de requisitos e instala as bibliotecas
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia a pasta da API para dentro do diretório de trabalho
COPY ./app /code/app

# Comando para rodar a aplicação
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]