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
# ---------- Frontend Build ----------
FROM node:22.13.1-alpine AS frontend-build
WORKDIR /frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend .
RUN npm run build

# ---------- Backend ----------
FROM node:22.13.1-alpine
WORKDIR /app

COPY backend/package*.json ./
RUN npm install

COPY backend .
COPY --from=frontend-build /frontend/build ./frontend-build

EXPOSE 80
CMD ["node", "server.js"]
