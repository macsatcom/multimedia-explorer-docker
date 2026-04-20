FROM oven/bun:1.2-alpine
RUN apk add --no-cache git

WORKDIR /app

# Clone source and install deps at image build time (no API key needed yet)
RUN git clone https://github.com/OpenRouterTeam/multimedia-explorer.git .
RUN bun install --frozen-lockfile

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Next.js build runs at container startup so NEXT_PUBLIC_ env vars
# from docker-compose / docker run are available during the build step.
CMD sh -c "bun run build && bun run start"
