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

# Limpar cache do npm
RUN npm cache clean --force

# Apaga o package-lock.json e a pasta node_modules para evitar conflitos
RUN rm -f package-lock.json && rm -rf node_modules

# Instala as dependências com npm e adiciona verbose para debug
RUN npm install --legacy-peer-deps --no-audit --no-fund --verbose

# Alternativa: rodar o comando ci e depois limpar as dependências de desenvolvimento
# RUN npm ci --only=production

# Exposição de portas (ajuste conforme necessário)
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["npm", "start"]
