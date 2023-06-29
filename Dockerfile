#FROM --platform=linux/amd64 node:19.2-alpine
#FROM --platform=$BUILDPLATFORM node:19.2-alpine

## Aca empieza el paso 1 con el as idnica que es la etapa 1 
FROM node:19.2-alpine as dependencias

# /app ya viene con esa carpeta cread por defecto el alpine
# Es como hacer un CD a  la carpeta app
WORKDIR /app

#destino /app
# COPY app.js package.json ./
COPY package.json ./
#ejecuta el comando npm install para instalar las dependencias
RUN npm install

##Este es mi paso 2 basicamente el crea una nueva imagen 
FROM node:19.2-alpine as builder

WORKDIR /app

##copia las depetencias el state las deptendencias de app/node_modules a mi carpeta /app/node_modules
COPY --from=dependencias /app/node_modules ./node_modules

# copia todo COPY . .
COPY . .

#realizar testing
RUN npm run test

#Etapa 3 donde crea las dependencias de producción
FROM node:19.2-alpine as prod-deps
WORKDIR /app
COPY package.json ./
RUN npm install --prod

#Etapa 5 ejecuta ya la app
FROM node:19.2-alpine as runner
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY app.js ./
COPY tasks/ ./tasks

#despues de que se monta la imagen que comenado quiere ejecutar luego de que se monte
CMD ["node", "app.js"]