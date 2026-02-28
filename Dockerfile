#Build stage
FROM node:22-alpine as build

WORKDIR /app

COPY package*.json ./
RUN apk add --no-cache python3 make g++ \
    && npm install

COPY . .
RUN npm run build

#Production stage
FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]