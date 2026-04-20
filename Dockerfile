FROM node:22-alpine
RUN apk add --no-cache git curl unzip && \
    curl -fsSL https://bun.sh/install | sh
ENV PATH="/root/.bun/bin:$PATH"

WORKDIR /app

# Clone source and install deps
RUN git clone https://github.com/OpenRouterTeam/multimedia-explorer.git .
RUN bun install --frozen-lockfile

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Build runs at startup so NEXT_PUBLIC_ env vars from docker-compose are available
CMD sh -c "node_modules/.bin/next build && node_modules/.bin/next start"
