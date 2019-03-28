FROM node:10-alpine

RUN adduser -D -h /home/app app \
 && apk add --update --no-cache \
    bash \
    jq \
    git
WORKDIR /home/app
ARG WIKI_PACKAGE=wiki@0.17.0
RUN su app -c "npm install -g --prefix . $WIKI_PACKAGE"
RUN su app -c "mkdir .wiki"
COPY configure-wiki set-owner-name ./
RUN chown app configure-wiki set-owner-name
VOLUME "/home/app/.wiki"
ENV DOMAIN=localhost
ENV OWNER_NAME="The Owner"
ENV COOKIE=insecure
EXPOSE 3000
USER app
CMD ["/home/app/bin/wiki"]
