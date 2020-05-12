# Istio

Source:

```bash
tk create source git webapp-infra \
  --url=https://github.com/gitopsrun/webapp-infra \
  --branch=master \
  --interval=1m
```

Istio operator:

```bash
tk create kustomization istio-operator \
  --source=webapp-infra \
  --path="./istio/operator" \
  --prune=true \
  --validate=client \
  --interval=1h \
  --health-check="Deployment/istio-operator.istio-operator" \
  --health-check-timeout=3m
```

Istio control plane:

```bash
tk create kustomization istio-system \
  --depends-on=istio-operator \
  --source=webapp-infra \
  --path="./istio/system" \
  --prune=true \
  --interval=1h \
  --health-check="Deployment/istiod.istio-system" \
  --health-check-timeout=3m
```

Flagger:

```bash
tk create kustomization flagger \
  --depends-on=istio-system \
  --source=webapp-infra \
  --path="./istio/flagger" \
  --prune=true \
  --interval=1h \
  --health-check="Deployment/flagger.istio-system" \
  --health-check-timeout=3m
```