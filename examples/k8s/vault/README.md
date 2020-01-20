# HashiCorp Vault in kubernetes

HashiCorp recomend installing vault via helm. Your author prefers
plain old kubernetes configs.

So we generated the yaml via helm's template command.

    helm template incubator/vault \
      --name-template=vault \
      --replicaCount=1 \
      --set vault.dev=false \
      --set vault.config.storage.file.path=/macos/.wiki-k8s/vault \
    | egrep -v 'heritage: "?Helm"?' \
    > vault.html

    kubectl apply -k .
    kubectl port-forward svc/vault 8200:8200 &> /dev/null &

    export VAULT_ADDR=http://127.0.0.1:8200
    vault status
    vault operator init
    vault operator unseal
    # paste key-fragment 1
    vault operator unseal
    # paste key-fragment 2
    vault operator unseal
    # paste key-fragment 3
    vault login
    # paste root token
