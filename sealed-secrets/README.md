# Sealed Secrets

Source:

```bash
tk create source git webapp-infra \
  --url=https://github.com/gitopsrun/webapp-infra \
  --branch=master \
  --interval=1m
```

Sealed Secrets controller:

```bash
tk create kustomization sealed-secrets \
  --source=webapp-infra \
  --path="./sealed-secrets" \
  --prune=true \
  --validate=client \
  --interval=1h \
  --health-check="Deployment/sealed-secrets-controller.sealed-secrets" \
  --health-check-timeout=3m
```

Install kubeseal:

```bash
brew install kubeseal
```

Download public key:

```bash
kubeseal --fetch-cert \
--controller-namespace=sealed-secrets \
> pub-cert.pem
```

Download the private key:

```bash
kubectl -n sealed-secrets get secret \
-l sealedsecrets.bitnami.com/sealed-secrets-key \
-o yaml > sealed-secrets-key.yaml
```

Generate sealed secret:

```bash
kubectl -n default create secret generic basic-auth \
--from-literal=user=admin \
--from-literal=password=admin \
--dry-run \
-o json > basic-auth.json

kubeseal --format=yaml --cert=pub-cert.pem < basic-auth.json > basic-auth.yaml

rm basic-auth.json
```
