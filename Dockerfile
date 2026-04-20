FROM oven/bun:1.2-alpine AS base
RUN apk add --no-cache git

WORKDIR /app

# Clone the source
RUN git clone https://github.com/OpenRouterTeam/multimedia-explorer.git .

# Install dependencies
RUN bun install --frozen-lockfile

# Build
RUN bun run build

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["bun", "run", "start"]
