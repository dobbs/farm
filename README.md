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
TAG=1.0.8-prefer-title
IMAGE=dobbs/farm:$TAG
docker build --tag $IMAGE .
```

With the local kubernetes example (see [examples/k8s/README.md](./examples/k8s/README.md)):

``` bash
k3d image import $IMAGE --cluster wiki
kubectl patch deployment.apps/wiki-deployment \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"'$IMAGE'"}]'
```

# Publish containers with experimental code

GitHub
``` bash
git tag -am "" "$TAG"
git push --atomic origin main "$TAG"
```

Docker Hub

``` bash
docker push $IMAGE
```
