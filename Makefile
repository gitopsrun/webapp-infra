ISTIO_VERSION:="1.5.2"
SEALED_SECRETS_VERSION:="0.12.3"

update-istio:
	curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=$(ISTIO_VERSION) sh -
	helm template ./istio-$(ISTIO_VERSION)/install/kubernetes/operator/charts/istio-operator/ \
	  --set hub=docker.io/istio \
	  --set tag=$(ISTIO_VERSION) \
	  --set operatorNamespace=istio-operator \
	  --set istioNamespace=istio-system  > ./istio/operator/manifests.yaml
	rm -rf ./istio-$(ISTIO_VERSION)

update-sealed-secrets:
	curl -sL https://github.com/bitnami-labs/sealed-secrets/releases/download/v${SEALED_SECRETS_VERSION}/controller.yaml \
	> ./sealed-secrets/controller.yaml
