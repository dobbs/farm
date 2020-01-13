# Wiki Farm in Kubernetes

There are easier ways to get started with federated wiki. Here we are
using wiki to drive some learning about kubernetes.

# We're using MacOS, Docker Desktop, and k3d

    brew cask install docker
    brew install k3d

    mkdir -p ~/.wiki-k8s ~/workspace/fedwiki
    k3d create \
      --publish 80:80 \
      -v "$HOME/.wiki-k8s:/macos/.wiki-k8s" \
      -v "$HOME/workspace/fedwiki:/macos/fedwiki" \
      --name wiki

# Deploy Wiki

    kubectl apply -f wiki.yaml

# Play with the wiki

    open http://simple.localtest.me
