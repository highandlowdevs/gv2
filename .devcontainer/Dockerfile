FROM debian:bookworm-slim

COPY install.sh /app/install.sh
COPY start.sh /app/start.sh
COPY config.json /etc/config.json

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash git curl wget unzip tzdata openssl ca-certificates python3 procps \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x /app/install.sh /app/start.sh && /app/install.sh

CMD ["sleep", "infinity"]
