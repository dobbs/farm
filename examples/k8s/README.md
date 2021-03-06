# Wiki Farm in Kubernetes

There are easier ways to get started with federated wiki. Here we are
using wiki to drive some learning about kubernetes.

# We're using MacOS, Docker Desktop, and k3d

    brew install --cask docker
    brew install k3d

    mkdir -p ~/.wiki-k8s ~/workspace/fedwiki
    k3d create \
      --server-arg --tls-san="127.0.0.1" \
      --publish 80:80 \
      -v "$HOME/.wiki-k8s:/macos/.wiki-k8s" \
      -v "$HOME/workspace/fedwiki:/macos/fedwiki" \
      --name wiki

# example ~/.wiki-k8s/config.json

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
        },
        "example.com": {
          "id": "/home/node/.wiki/example.com.owner.json"
        }
      }
    }

# example ~/.wiki-k8s/localhost.owner.json

`.friend.secret` must match the `.admin` field from `config.json`

    {
      "name": "The Owner",
      "friend": {
        "secret": "any memorable password"
      }
    }


# Deploy Wiki

    kubectl apply -f http://deploy.wiki.do/assets/wiki/wiki.yaml

# Play with the wiki

    open http://wiki.localhost
