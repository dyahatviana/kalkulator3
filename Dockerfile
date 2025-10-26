FROM node:18-alpine AS builder

WORKDIR /app

RUN npm install -g expo-cli

COPY package*.json ./

RUN npm install


COPY . .

RUN npx expo export:web

FROM nginx:alpine

COPY --from=builder /app/web-build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]