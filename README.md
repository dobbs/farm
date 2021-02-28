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

# Development

This image's tag does not match the version of the included wiki
software. Our version indicates the scale of changes in this tiny
devops pipeline.

Testing new images locally:

``` bash
IMAGE=dobbs/farm:1.0.7-pre-22
docker build --tag $IMAGE .
```

With the local kubernetes example (see [examples/k8s/README.md](./examples/k8s/README.md)):

``` bash
export IMAGE=dobbs/farm:1.0.7-pre-22
docker build --tag $IMAGE .
k3d image import $IMAGE --cluster wiki
cd ./examples/k8s/
perl -pi -e 's{^(\s+image:\s*).*$}{\1 $ENV["IMAGE"]}' wiki.yaml
kubectl apply -f wiki.yaml
```

The repos in Dockerhub and GitHub are configured to automatically build new tags.

# Publish experimental plugins

Invoke Dockerhub and GitHub integration.
``` bash
git tag -am "" '1.0.2-pre-0217'
git push --atomic origin main '1.0.2-pre-0217'
```
