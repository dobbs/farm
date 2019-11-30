FROM node:lts-alpine

RUN apk add --update --no-cache \
  dumb-init \
  git \
  jq
WORKDIR "/home/node"
ARG WIKI_PACKAGE=https://wiki-dev.glitch.me/wiki-0.20.1-restrict-new-wiki.0.tgz
RUN su node -c "npm install -g --prefix . $WIKI_PACKAGE"
RUN su node -c "mkdir -p .wiki"
VOLUME "/home/node/.wiki"
EXPOSE 3000
USER node
ENV PATH="${PATH}:/home/node/bin"
ENTRYPOINT ["dumb-init"]
CMD ["wiki", "--farm", "--security_type=friends"]
