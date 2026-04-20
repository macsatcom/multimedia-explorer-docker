FROM node:22-alpine
RUN apk add --no-cache git

WORKDIR /app

# Clone source and install deps
RUN git clone https://github.com/OpenRouterTeam/multimedia-explorer.git .

# Patch crypto.randomUUID() calls to include a fallback for non-HTTPS contexts
# (crypto.randomUUID requires a secure context; HTTP on local IPs is not secure)
RUN find . -name "*.tsx" -o -name "*.ts" | xargs grep -l "crypto\.randomUUID()" | \
    xargs sed -i "s/crypto\.randomUUID()/crypto.randomUUID?.() ?? Math.random().toString(36).slice(2) + Date.now().toString(36)/g"

RUN npm install

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Build runs at startup so NEXT_PUBLIC_ env vars from docker-compose are available
CMD ["sh", "-c", "node_modules/.bin/next build && node_modules/.bin/next start"]
