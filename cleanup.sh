#!/bin/sh


#remove all the ksvc's we made
kubectl delete -f ./templates/consumer.yaml

kubectl delete -f ./templates/webhook.yaml


#remove the channel

ko delete -f ./templates/kafka-channel.yaml

ko delete -f ./templates/kafka.yaml

kubectl delete -f ./templates/cassandra-job.yaml


#remove helm charts
helm delete cassandra --purge

helm delete my-kafka --purge

kubectl delete ns cassandra

kubectl delete ns kafka

