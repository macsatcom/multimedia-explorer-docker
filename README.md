# multimedia-explorer-docker

Unofficial Docker setup for [OpenRouterTeam/multimedia-explorer](https://github.com/OpenRouterTeam/multimedia-explorer) — an open-source multi-model media generation tool by [OpenRouter](https://openrouter.ai).

The Docker image is automatically rebuilt whenever the upstream repository receives new commits.

## What is multimedia-explorer?

A unified interface for generating images and videos using dozens of AI models available through the OpenRouter API. Pick a model, type a prompt, and get results. Supports reference images, brand moodboards, and a generation history timeline.

Try the hosted version at [multimedia-explorer.openrouter.ai](https://multimedia-explorer.openrouter.ai).

## Prerequisites

You need an OpenRouter API key from [openrouter.ai/keys](https://openrouter.ai/keys).

Create a `.env` file in the same directory as your `docker-compose.yml`:

```env
NEXT_PUBLIC_OPENROUTER_API_KEY=sk-or-v1-...
```

> **Note:** `NEXT_PUBLIC_OPENROUTER_API_KEY` is a Next.js build-time variable — it gets baked into the JavaScript bundle when the app compiles. To work around this, the container runs `next build` at startup, so any env vars you pass via `docker run -e` or `docker-compose` are available during the build. The first startup takes ~30–60 seconds while the app builds; subsequent restarts are fast thanks to the cached build volume.

## Usage

### Docker

```bash
docker run -p 3000:3000 \
  -e NEXT_PUBLIC_OPENROUTER_API_KEY=sk-or-v1-... \
  ghcr.io/macsatcom/multimedia-explorer-docker:latest
```

Then open [http://localhost:3000](http://localhost:3000).

### Docker Compose

Create a `docker-compose.yml`:

```yaml
services:
  multimedia-explorer:
    image: ghcr.io/macsatcom/multimedia-explorer-docker:latest
    ports:
      - "3000:3000"
    environment:
      - NEXT_PUBLIC_OPENROUTER_API_KEY=sk-or-v1-...
    restart: unless-stopped
```

Start with:

```bash
docker compose pull && docker compose up -d
```

## Auto-updates

A GitHub Action checks the upstream repository every 6 hours and rebuilds the image automatically if new commits are detected. You can pull the latest image with:

```bash
docker pull ghcr.io/macsatcom/multimedia-explorer-docker:latest
```

## Source

- Upstream app: [OpenRouterTeam/multimedia-explorer](https://github.com/OpenRouterTeam/multimedia-explorer)
- This repo: [macsatcom/multimedia-explorer-docker](https://github.com/macsatcom/multimedia-explorer-docker)
