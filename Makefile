ISTIO_VERSION:="1.5.2"

update-istio:
	curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=$(ISTIO_VERSION) sh -
	helm template ./istio-$(ISTIO_VERSION)/install/kubernetes/operator/charts/istio-operator/ \
	  --set hub=docker.io/istio \
	  --set tag=$(ISTIO_VERSION) \
	  --set operatorNamespace=istio-operator \
	  --set istioNamespace=istio-system  > ./istio/operator/manifests.yaml
	rm -rf ./istio-$(ISTIO_VERSION)
