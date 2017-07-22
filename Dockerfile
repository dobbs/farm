FROM node:4-slim

RUN useradd --create-home app \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    jq
WORKDIR /home/app
RUN su app -c "npm install -g --prefix . wiki@0.11.4"
RUN su app -c "mkdir .wiki"
COPY configure-and-launch-wiki configure-and-launch-wiki
RUN chown app configure-and-launch-wiki
VOLUME "/home/app/.wiki"
ENV DOMAIN=localhost
ENV OWNER_NAME="The Owner"
ENV COOKIE=insecure
EXPOSE 3000
USER app
CMD ["./configure-and-launch-wiki"]
