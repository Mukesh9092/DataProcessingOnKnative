#!/bin/sh


#install istio
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.4.0/istio-crds.yaml && \
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.4.0/istio.yaml

#label default ns with istio injection enabled. This should make it so that every pod in the default ns is part of the istio service mesh
kubectl label namespace default istio-injection=enabled

#check the istio ns to see if everything is done being setup
kubectl get pods --namespace istio-system 

#install knative
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.5.0/serving.yaml \
--filename https://github.com/knative/build/releases/download/v0.5.0/build.yaml \
--filename https://github.com/knative/eventing/releases/download/v0.5.0/release.yaml \
--filename https://github.com/knative/eventing-sources/releases/download/v0.5.0/eventing-sources.yaml \
--filename https://github.com/knative/serving/releases/download/v0.5.0/monitoring.yaml \
--filename https://raw.githubusercontent.com/knative/serving/v0.5.0/third_party/config/build/clusterrole.yaml


