FROM node:lts-alpine

RUN apk add --update --no-cache \
  dumb-init \
  git \
  jq
WORKDIR "/home/node"
ARG WIKI_PACKAGE=wiki@0.21.0
ARG WIKI_CLIENT=wiki-client@0.20.1
ARG WIKI_SERVER=wiki-server@0.17.5
RUN su node -c "npm install -g --prefix . $WIKI_PACKAGE" \
 && su node -c "cd /home/node/lib/node_modules/wiki && npm install --save $WIKI_CLIENT $WIKI_SERVER"
RUN su node -c "mkdir -p .wiki"
VOLUME "/home/node/.wiki"
EXPOSE 3000
USER node
ENV PATH="${PATH}:/home/node/bin"
# Adding this line to make local plugin development easier
# see https://local-farm.wiki.dbbs.co/make-a-new-plugin.html
ENV NPM_CONFIG_PREFIX="${HOME}"
ENTRYPOINT ["dumb-init"]
CMD ["wiki", "--farm", "--security_type=friends"]
