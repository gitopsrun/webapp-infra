# Webapp

Source:

```bash
tk create source git webapp-infra \
  --url=https://github.com/gitopsrun/webapp-infra \
  --branch=master \
  --interval=1m
```

Webapp staging:

```bash
tk create kustomization webapp-staging \
  --depends-on=istio-system \
  --source=webapp-infra \
  --path="./webapp/overlays/staging" \
  --prune=true \
  --validate=client \
  --interval=30m
```

Webapp production:

```bash
tk create kustomization webapp-production \
  --depends-on=istio-system \
  --source=webapp-infra \
  --path="./webapp/overlays/production" \
  --prune=true \
  --validate=client \
  --interval=30m
```
