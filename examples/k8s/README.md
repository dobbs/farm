# Wiki Farm in Kubernetes

There are easier ways to get started with federated wiki. Here we are
using wiki to drive some learning about kubernetes.

# We're using MacOS, Docker Desktop, and kind

    brew cask install docker
    brew install kind
    kind create cluster --name wiki

# Deploy Wiki

    kubectl apply -f wiki.yaml

# Play with the wiki

    # pbcopy & open are MacOS commands
    kubectl port-forward svc/wiki-service 3000:80 \
      > port-forward.log \
      2> port-forward.err &
    # get admin password on the clipboard
    kubectl exec svc/wiki-service -- \
      jq -r .admin .wiki/config.json \
      | pbcopy
    open http://localhost:3000
    # login with the password on the clipboard
