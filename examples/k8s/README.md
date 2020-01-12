# Wiki Farm in Kubernetes

There are easier ways to get started with federated wiki. Here we are
using wiki to drive some learning about kubernetes.

# We're using MacOS, Docker Desktop, and k3d

    brew cask install docker
    brew install k3d
    k3d create --publish 80:80 --name wiki

# Deploy Wiki

    kubectl apply -f wiki.yaml

# Play with the wiki

    open http://simple.localtest.me
