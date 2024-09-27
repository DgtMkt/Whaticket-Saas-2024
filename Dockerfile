# Utiliza a imagem base Node 16
FROM node:16

# Atualiza o sistema e instala pacotes necessários
RUN apt-get update && \
    apt-get install -y sudo curl wget nginx postgresql redis && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list' && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# Cria os diretórios necessários e define permissões
RUN mkdir -p /app && \
    chown -R node:node /app

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto para o diretório de trabalho no container
COPY . /app

# Instala as dependências do Node.js
RUN npm install --force

# Exponha a porta 8080 para o backend
EXPOSE 8080

# Exponha a porta 80 para o frontend
EXPOSE 80

# Comando para iniciar o servidor quando o container subir
CMD ["npm", "start"]

