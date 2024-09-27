# Utiliza uma imagem base do Node.js para a aplicação backend
FROM node:16

# Instala as dependências do sistema necessárias
RUN apt-get update && \
    apt-get install -y sudo curl wget nginx postgresql redis && \
    apt-get install -y google-chrome-stable

# Define o diretório de trabalho no container
WORKDIR /app

# Copia todos os arquivos do projeto para o container
COPY . .

# Dá permissão de execução aos scripts .sh
RUN chmod +x lib/*.sh
RUN chmod +x utils/*.sh
RUN chmod +x variables/*.sh

# Instala as dependências do Node.js para o backend
RUN cd /app/backend && npm install --force

# Configura o Redis e o banco de dados
RUN ./lib/_backend.sh

# Exponha as portas necessárias (8080 para o backend e 80 para o Nginx)
EXPOSE 8080
EXPOSE 80

# Inicializa o PM2 para rodar o backend e inicia o Nginx
CMD ["pm2-runtime", "start", "whatstalk/server.js", "--name", "whaticket-backend"] && service nginx start
