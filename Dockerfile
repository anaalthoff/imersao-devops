# Quando cria o Dockerfile, ele vem de uma base, o 'FROM'. A base pode vir de vários repositórios de imagens.
# Busca do Docker Hub, maior repositório de imagens que existe.
# COmo a aplicação é escrita em python, buscar uma imagem Python, que terá o mínimo viável para rodara aplicação python
# A imagem -alpine é uma boa escolha por ser leve. Usaremos uma tag de versão estável para reprodutibilidade.
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo de requisitos e instala dependências
# O build só reinstalará as dependências se o requirements.txt for alterado.
# Assumindo que o contexto do build é o diretório 'imersao-devops'
COPY requirements.txt .
# Instala as dependências com --no-cache-dir para evitar o cache do pip, reduzindo tamanho.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação uvicorn
# O host 0.0.0.0 é necessário para que a aplicação seja acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
