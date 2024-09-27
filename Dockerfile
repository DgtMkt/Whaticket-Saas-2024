# Defina a imagem base Node.js
FROM node:16

# Instala dependências do sistema
RUN apt-get update && \
    apt-get install -y sudo curl wget nginx postgresql redis && \
    apt-get install -y gnupg && \
    curl -sSL https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Definir diretório de trabalho
WORKDIR /usr/src/app

# Copiar package.json e package-lock.json antes de copiar o restante dos arquivos
COPY package*.json ./

# Instalar dependências do npm
RUN npm install --legacy-peer-deps --no-audit --no-fund --verbose

# Copiar o restante dos arquivos da aplicação
COPY . .

# Expor a porta (ajuste conforme necessário)
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["npm", "start"]
