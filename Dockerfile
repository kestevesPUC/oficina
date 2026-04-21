
# 1️⃣ Stage de build
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --force


COPY . .
RUN npm run build


# 2️⃣ Stage de produção
FROM nginx:alpine


# Remove config default
RUN rm /etc/nginx/conf.d/default.conf


# Copia config customizada
COPY nginx.conf /etc/nginx/conf.d


# Copia os arquivos buildados
COPY --from=build /app/dist /usr/share/nginx/html


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
