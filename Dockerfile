# ── Build stage: compile Tailwind to a static, minified CSS file ──────────────
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# ── Serve stage: nginx serving only static assets (last stage → Coolify builds it)
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html robots.txt sitemap.xml /usr/share/nginx/html/
COPY --from=build /app/dist/styles.css /usr/share/nginx/html/styles.css
EXPOSE 3000
