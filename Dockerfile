# Defina a imagem base Node.js
FROM node:16

# Instala dependências do sistema
RUN apt-get update && \
    apt-get install -y sudo curl wget nginx postgresql redis && \
    apt-get install -y gnupg && \
    curl -sSL https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Crie um diretório para a aplicação
WORKDIR /usr/src/app

# Copie os arquivos da aplicação para o contêiner
COPY . .

# Apaga o package-lock.json e a pasta node_modules para evitar conflitos
RUN rm -f package-lock.json && rm -rf node_modules

# Instala as dependências com npm, e força a instalação caso ocorram erros
RUN npm install --force

# Alternativa: rodar o comando ci e depois limpar as dependências de desenvolvimento
# RUN npm ci --only=production

# Comando para iniciar a aplicação (ajuste conforme sua necessidade)
CMD ["npm", "start"]
