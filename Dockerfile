FROM node:4-slim

RUN useradd --create-home app \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    jq
WORKDIR /home/app
ARG VERSION=0.11.4
RUN su app -c "npm install -g --prefix . wiki@$VERSION"
RUN su app -c "mkdir .wiki"
COPY configure-and-launch-wiki set-owner-name ./
RUN chown app configure-and-launch-wiki set-owner-name
VOLUME "/home/app/.wiki"
ENV DOMAIN=localhost
ENV OWNER_NAME="The Owner"
ENV COOKIE=insecure
EXPOSE 3000
USER app
CMD ["./configure-and-launch-wiki"]
