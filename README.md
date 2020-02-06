# Federated Wiki Farm

Start Playing Federated Wiki: http://start.fed.wiki

### Run a local wiki farm

    docker run -p 3000:3000 -it --rm \
      dobbs/farm

Visit http://localhost:3000 and http://anything.localtest.me:3000

### Run a local wiki that will survive a reboot

    docker run -p 3000:3000 -it --rm \
      -v ~/.wiki:/home/node/.wiki \
      dobbs/farm

Your wiki pages and configuration will be saved in the ~/.wiki folder.

# Release Notes for 1.0.0

This is a significant **breaking** change from pre-1.0 releases. Especially:

* changed the user from `app` (`uid=1001(app) gid=1001(app) groups=1001(app)`)
  to `node` (`uid=1000(node) gid=1000(node) groups=1000(node),1000(node)`)

* no longer installing `bash`, `configure-wiki`, nor `set-owner-name`

* no longer creating `/home/app/.wiki/wiki.json`

Those changes in particular will impose some work on authors upgrading
from previous versions.

The last non-breaking revision is 0.52.0 https://github.com/dobbs/farm/tree/0.52.0#readme

# Development

This image's tag does not match the version of the included wiki
software. Our version indicates the scale of changes in this tiny
devops pipeline. For example, when we changed the `USER` directive and
removed the wiki config generation scripts, we bumped the major
version from 0.50.x to 1.0.x.

Notes to self:

``` bash
docker build --tag dobbs/farm:1.0.2 .
git tag -am "" '1.0.2'
git push origin '1.0.2'
```

The repos in Dockerhub and GitHub are configured to automatically build new tags.

# Publish experimental plugins

``` bash
docker build \
  --tag dobbs/farm:0.14.0-frame \
  --build-arg WIKI_PACKAGE='dobbs/wiki#frame' \
  .
docker push dobbs/farm:0.14.0-frame
```
