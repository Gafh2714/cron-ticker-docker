#FROM --platform=linux/amd64 node:19.2-alpine
#FROM --platform=$BUILDPLATFORM node:19.2-alpine
FROM node:19.2-alpine

# /app ya viene con esa carpeta cread por defecto el alpine

# Es como hacer un CD a  la carpeta app
WORKDIR /app

#destino /app
# COPY app.js package.json ./

COPY package.json ./

#ejecuta el comando npm install para instalar las dependencias
RUN npm install


# copia todo COPY . .
COPY . .


#realizar testing
RUN npm run test

#ejecuta el comando npm install para instalar las dependencias
#RUN npm install

#Eliminar  archivos y directorios no necesarios en producción -rf =recursivo forzado
RUN rm -rf test && rm -rf node_modules

#uniamnete las dependencias de producción
RUN npm install --prod

#despues de que se monta la imagen que comenado quiere ejecutar luego de que se monte
CMD ["node", "app.js"]