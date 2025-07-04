# Imersão DevOps - Alura Google Cloud

Este projeto é uma API desenvolvida com FastAPI para gerenciar alunos, cursos e matrículas em uma instituição de ensino.

Atualmente a empresa em que trabalho utiliza Docker, CI/CD, pipeline e várias ferramentas para automatizar e entregar processos continuamente. Inclusive, já criei dockerfile, docker compose, verifico as pipelines e trabalho com frequência com DevOps. Porém, achei necessário ingressar neste curso para conseguir entender melhor o passo a passo, os porquês e como e quando tudo funciona.

O projeto em python não foi de minha criação, ele foi importado de https://github.com/guilhermeonrails/ellis. A criação dos arquivos posteriores foram feitas por mim. No ReadMe deixarei o passo a passo dessa criação e algumas explicações.


## Pré-requisitos

- [Python 3.10 ou superior instalado](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)
- [Docker](https://www.docker.com/get-started/)

## Passos para subir o projeto

1. **Faça o download do repositório:**
   [Clique aqui para realizar o download](https://github.com/guilhermeonrails/imersao-devops/archive/refs/heads/main.zip)

2. **Crie um ambiente virtual:**
   ```sh
   python3 -m venv ./venv
   ```

3. **Ative o ambiente virtual:**
   - No Linux/Mac:
     ```sh
     source venv/bin/activate
     ```
   - No Windows, abra um terminal no modo administrador e execute o comando:
   ```sh
   Set-ExecutionPolicy RemoteSigned
   ```

     ```sh
     venv\Scripts\activate
     ```

4. **Instale as dependências:**
   ```sh
   pip install -r requirements.txt
   ```

5. **Execute a aplicação:**
   ```sh
   uvicorn app:app --reload
   ```

6. **Acesse a documentação interativa:**

   Abra o navegador e acesse:  
   [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

   Aqui você pode testar todos os endpoints da API de forma interativa.

---

## Estrutura do Projeto

- `app.py`: Arquivo principal da aplicação FastAPI.
- `models.py`: Modelos do banco de dados (SQLAlchemy).
- `schemas.py`: Schemas de validação (Pydantic).
- `database.py`: Configuração do banco de dados SQLite.
- `routers/`: Diretório com os arquivos de rotas (alunos, cursos, matrículas).
- `requirements.txt`: Lista de dependências do projeto.

---

- O banco de dados SQLite será criado automaticamente como `escola.db` na primeira execução.
- Para reiniciar o banco, basta apagar o arquivo `escola.db` (isso apagará todos os dados).

---
## Criando documentos do Docker

1. **Crie o Doockerfile:**

   É um arquivo de definição do que vai ser rodado. São comandos que informam o que será rodado quando o container do Docker subir.
   Criar na raiz do projeto.

2. **Pode criar o .dockerignore**

3. **Buildar o dockerfile:**

   Buildar é criar a imagem do docker. -t é de tag, tag cria um nome para a imagem e o ponto é o diretório
   
   ```sh
   docker build -t imersao-devops .
   ```

4. **Verificar a imagem do docker:**

   ```sh
   docker images
   ```

5. **Executar e rodar a aplicação dentro da imagem:**

   Sobre a porta 8000, aparece duas vezes, porque está mapeando a porta do container e a porta da aplicação. Elas podem ser diferentes, mas nesse contexto foram iguais.

   ```sh
   docker run -p 8000:8000 imersao-devops
   ```

6. **Criação do docker compose:**

   É um yaml, vai organizar a forma de rodar o docker. Ao invés de rodar em linha de comando, ou na UI do desktop, roda o docker compose. Ótimo para contexto de várias aplicações. Exemplo: subir um wordpress, e depois precisa de um banco de dados, a própria aplicação, e sobe tudo junto.
   Antes: criava-se o ambiente virtual, ativava a 'venv', etc. Agora, com o docker compose, haverá um comando para a plicação subir. Entra na ideia do CI (Continuous Integration - Integração Contínua). Com o comando abaixo, faz o build e o run.
   Assim, com o dockerfile e o docker compose, os itens 2 a 5 de 'pré-requisitos' não precisam ser feitos.
   Lembrando: para executar esse projeto em qualquer máquina, tem que ter o Docker, fazer o download do projeto, acessar a pasta onde o projeto está, a raiz, e escrever o comando abaixo: 

   ```sh
   docker compose  up
   ```

   Projeto está de pé!

   Dica: quando for rodar http://0.0.0.0:8000/docs, substitua por http://localhost:8000/docs

## Utilizando Google Cloud

**Se quiser utilizar o Google Cloud:**

   É um servidor na nuvem que faz com que a aplicação fique disponível não apenas em sua máquina.
   Para instalar, acesse: https://cloud.google.com/sdk/docs/install#windows
   Após instalação, reinicie o VS Code.
   Para autenticar no Google Cloud, utilize os 3 comandos abaixo:

   ```sh
   gcloud auth login
   gcloud config set project PROJECT_ID
   gcloud run deploy --port=8000
   ```

   Ao executar a última linha, ele perguntará "deploy do que?". Significa que tem que informar uma pasta. Ele irá sugerir uma pasta, se for ela, apenas dar enter. Se não, escrever a pasta correta.
   Exemplo: Source code location (C:\Users\exemplo\Desktop\imersao-devops):

   Depois vai pedir o nome do serviço. Escolha um.

   Alguns conceitos:
   artifactregistry -> onde vai guardar a imagem do Docker
   cloudbuild -> o google fará o build dessa imagem
   run -> sobe a aplicação na nuvem no ambiente serveless para todos terem acesso. Faz a configuração de rede e disponibiliza na porta informada
   Aperte sim (Y), quando essas opções aparecerem para tudo poder rodar.
   Quando surgir: Allow unauthenticated invocations to [app], se não apertar em 'sim' (y), se não autorizar, cada vez que alguém for acessar a aplicação, tem que dar permissão. Quem não tem acesso, dá erro 403. 