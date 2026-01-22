# ---------- Frontend Build ----------
FROM node:22.13.1-alpine AS frontend-build
WORKDIR /frontend

# Copy full React app
COPY my-app/ ./my-app/

WORKDIR /frontend/my-app
RUN npm install
RUN npm run build

# ---------- Backend Runtime ----------
FROM node:22.13.1-alpine
WORKDIR /app

COPY server/package*.json ./
RUN npm install

COPY server .
COPY --from=frontend-build /frontend/my-app/build ./public

ENV PORT=80
EXPOSE 80

CMD ["node", "server.js"]
