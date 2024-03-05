FROM node:alpine3.19
WORKDIR /app
COPY package.json package.json
RUN npm install
RUN npm install dotenv  
COPY . /app
CMD npm start