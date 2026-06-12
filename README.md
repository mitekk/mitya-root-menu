<div align="center">

# 🏠 mitya.dev

**The root landing page for the mitya.dev domain** — _launch · link out · stay tiny_

![Tailwind](https://img.shields.io/badge/Tailwind-4-06b6d4?logo=tailwindcss&logoColor=white)
![Node](https://img.shields.io/badge/Node-22-7c3aed?logo=nodedotjs&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-alpine-009639?logo=nginx&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ed?logo=docker&logoColor=white)

A single static page that greets visitors at **[mitya.dev](https://mitya.dev)** and links out to the
deployed apps in the portfolio. No framework, no JavaScript app — just one hand-written `index.html`
styled with Tailwind and served by nginx.

</div>

---

- **Explore** — [What it is](#what-it-is) · [Quick start](#quick-start) · [How it's built](#how-its-built) · [Deployment](#deployment) · [Tech stack](#tech-stack)

---

## What it is

`mitya-root-menu` is the launcher page shown at the apex of the **mitya.dev** domain. It's a single
dark-themed card grid: each card links to one deployed app (Profile, Mashov, Pool-Stars, Pulse,
Lunaland) and, for the public ones, to its GitHub source. The page carries the site's SEO and social
metadata (Open Graph, Twitter Card, schema.org, sitemap, robots) and a Google Analytics tag.

It's deliberately minimal — there's no build framework and no client-side JavaScript, so it stays
fast and trivial to host.

## Quick start

Requires **Node 22+** (only to compile the Tailwind CSS).

```bash
npm install
npm run build      # compiles src/input.css -> dist/styles.css (minified)
```

Then open `index.html` in a browser, or serve the folder statically. There's no dev server — the page
is plain HTML plus the one compiled stylesheet.

## How it's built

```
.
├── index.html      # the page itself — header + project card grid
├── src/input.css   # Tailwind v4 source: @theme + the .card component layer
├── nginx.conf      # serves static files on :3000, /health -> 200
├── Dockerfile      # node build stage -> nginx serve stage
├── robots.txt      # crawler rules
└── sitemap.xml     # sitemap for mitya.dev
```

The only build step is Tailwind: `npm run build` reads `src/input.css` (which `@source`s
`index.html`) and emits a minified `dist/styles.css`. Card styling lives as reusable component
classes (`.card`, `.card-title`, …) so new project cards can be added by copying one
`<article class="card">` block.

## Deployment

Containerized and deployed via Coolify on the mitya.dev server:

1. **Build stage** (`node:22-alpine`) runs `npm ci` then `npm run build` to produce `dist/styles.css`.
2. **Serve stage** (`nginx:alpine`) copies `index.html`, `robots.txt`, `sitemap.xml` and the compiled
   stylesheet into the nginx web root and listens on **port 3000**.

nginx serves the static files with a plain-text `/health` endpoint for the platform health check.
Pushes to `main` auto-deploy to **[mitya.dev](https://mitya.dev)**.

## Tech stack

| Layer | Tech |
|---|---|
| Markup | Hand-written static `index.html` |
| Styling | Tailwind CSS v4 (`@tailwindcss/cli`) |
| Build | Node 22 (`npm run build`) |
| Serve | nginx (alpine) on :3000 |
| Container | Docker (multi-stage) |
| Analytics | Google Analytics (gtag) |
