# Webapp

Source:

```bash
tk create source git webapp-infra \
  --url=https://github.com/gitopsrun/webapp-infra \
  --branch=master \
  --interval=1m
```

Webapp:

```bash
tk create kustomization webapp \
  --depends-on=istio-system \
  --source=webapp-infra \
  --path="./webapp" \
  --prune=true \
  --validate=client \
  --interval=30m
```

