#Build stage
FROM node:18-alpine as Build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run Build

#Production stage
FROM nginx:stable-alpine

COPY --from=build /app/build /user/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]