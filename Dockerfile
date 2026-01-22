# # ---------- Build Stage ----------
# FROM node:22.13.1-alpine AS build
# WORKDIR /app

# COPY package*.json ./
# RUN npm install

# COPY . .
# RUN npm run build

# # ---------- Runtime Stage ----------
# FROM nginx:alpine
# COPY --from=build /app/build /usr/share/nginx/html

# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]



# ---------- Build React ----------
FROM node:22.13.1-alpine AS frontend-build
WORKDIR /frontend

COPY my-app/package*.json ./
RUN npm install
COPY my-app .
RUN npm run build

# ---------- Runtime ----------
FROM node:22.13.1-alpine
WORKDIR /app

COPY server/package*.json ./
RUN npm install

COPY server .
COPY --from=frontend-build /frontend/build ./public

ENV PORT=80
EXPOSE 80

CMD ["node", "server.js"]