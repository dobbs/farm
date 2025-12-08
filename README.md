# Federated Wiki Farm

Start Playing Federated Wiki: http://start.fed.wiki

### Run a local wiki farm

    docker run -p 3000:3000 -it --rm \
      dobbs/farm

Visit http://localhost:3000 and http://anything.localhost:3000

### Run a local wiki that will survive a reboot

    docker run -p 3000:3000 -it --rm \
      -v ~/.wiki:/home/node/.wiki \
      dobbs/farm

Your wiki pages and configuration will be saved in the ~/.wiki folder.

# Development

This image's tag does not match the version of the included wiki
software. Our version indicates the scale of changes in this tiny
devops pipeline.

Testing new images locally:

``` bash
TAG=1.0.14-prefer-title
IMAGE=dobbs/farm:$TAG
docker buildx build --tag $IMAGE --platform linux/amd64,linux/arm64 .
```

You might also want to remember the most recent tag:

``` bash
git tag --list | tail -1
```

Update WIKI_VERSIONS.txt

``` bash
docker run --rm $IMAGE wiki --version > WIKI_VERSIONS.txt
```

# Publish container images

End-to-end recipe to publish a new version. May require judgment in
the steps before git push and docker push.
``` bash
# Emit current version to standard error and next version to standard out.
# use that to assign the next TAG
TAG="$(git tag --list | tail -1 | perl -lne 'print STDERR $_;s/(\d+)$/$1+1/e;print $_;')"
IMAGE=dobbs/farm:$TAG
docker buildx build --no-cache --tag $IMAGE --platform linux/amd64,linux/arm64 .
docker tag $IMAGE dobbs/farm:latest
docker run --rm $IMAGE wiki --version > WIKI_VERSIONS.txt
git add .
git commit -m "upgrade to wiki 0.38.0"
git tag -am "" "$TAG"
git push --atomic origin main "$TAG"
docker push $IMAGE
docker push dobbs/farm:latest
```

Sometimes we publish a docker image with no changes to the wiki source
code. This allows us to pick up non-breaking changes to some of the
plugins. Using `--no-cache` ensures docker re-runs this line from the
`Dockerfile` in particular: `npm install -g --prefix . $WIKI_PACKAGE`.

# Experiment with a local farm

This example shows a configuration using the friends security plugin
and making all the wikis under the localhost domain owned by the same
author. The browser will demand a login for each localhost subdomain,
but will accept the same password for authentication.

## Create ~/tmp/wiki/config.json

    {
      "admin": "any memorable password",
      "autoseed": true,
      "farm": true,
      "cookieSecret": "any random string",
      "secure_cookie": false,
      "security_type": "friends",
      "wikiDomains": {
        "localhost": {
          "id": "/home/node/.wiki/localhost.owner.json"
        }
      }
    }

## Create ~/tmp/wiki/localhost.owner.json

`.friend.secret` must match the `.admin` field from `config.json`

    {
      "name": "The Owner",
      "friend": {
        "secret": "any memorable password"
      }
    }

## Run a local wiki that will use those config files and survive a reboot

    docker run -p 3000:3000 -it --rm \
      -v ~/tmp/wiki:/home/node/.wiki \
      dobbs/farm

## Visit a couple local wiki sites

http://foo.localhost:3000
http://bar.localhost:3000

You should be able to log into both of those local sites using
'any memorable password'. And if you create a few pages in each
wiki you can examine how the files are laid out in the `~/tmp/wiki`
folder where you have stored those config files.

# Experiment with K8S

With the local kubernetes example (see [examples/k8s/README.md](./examples/k8s/README.md)):

``` bash
k3d image import $IMAGE --cluster wiki
kubectl patch deployment.apps/wiki-deployment \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"'$IMAGE'"}]'
```
