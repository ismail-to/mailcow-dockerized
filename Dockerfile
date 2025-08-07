# 1. Start from Docker-in-Docker so we can run Docker commands inside
FROM docker:24.0.5-dind

# 2. Install curl and fetch the Compose v2 binary
RUN apk add --no-cache curl bash \
  && curl -SL https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-linux-x86_64 \
  -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose

WORKDIR /mailcow

# 3. Copy the whole repo in and run the generator
COPY . .
RUN chmod +x ./generate_config.sh \
  && ./generate_config.sh

# 4. Default command just brings up the stack
ENTRYPOINT ["docker-compose", "up", "-d", "--remove-orphans"]