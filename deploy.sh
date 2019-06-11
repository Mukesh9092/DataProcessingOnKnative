#!/bin/sh

#let's install kafka into our cluster using the helm incubator charts

helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
kubectl create ns kafka
kubectl create ns cassandra
helm install --name my-kafka --namespace kafka incubator/kafka

#let's add cassandra in from helm as well

helm install --namespace cassandra -n "cassandra" incubator/cassandra

#let's run a k8s job, that waits for cassandra to be up, then creates a keyspace (schema), this is because of it takes a minute for the DB to spin up, and the Cassandra client for nodejs, needs to connect to a premade schema.

kubectl apply -f ./templates/cassandra-job.yaml

#let's install kafka controller and get it part of the Knative system. Remember to have cloned the Knative/Eventing repo into your $GOPATH, and have 'ko' client installed

ko apply -f ./templates/kafka.yaml

#create the Kafka Channel

ko apply -f ./templates/kafka-channel.yaml

#We need to get the internal address of this newly created channel, since we will need it later. Luckily we can parse the created YAML with a simple command to get this

KAFKA_HOSTNAME=$(kubectl get channel my-kafka-channel -o jsonpath='{.status.address.hostname}')

#Now we can inject this address into the code by passing it as an ENV variable to the Knative Service and deploying it like so

sed -i "s/my-kafka-channel[^ ]*/$TEST/" ./templates/webhook.yaml
kubectl apply -f ./templates/webhook.yaml

#Add the consumer so that it can be fed data from the Kafka Channel
kubectl apply -f ./templates/consumer.yaml

#Set up DNS
kubectl apply -f ./templates/config-domain.yaml
