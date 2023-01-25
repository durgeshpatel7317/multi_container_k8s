#! /bin/sh

docker build -t durgeshpatel317/multi-client:latest -t durgeshpatel317/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t durgeshpatel317/multi-server:latest -t durgeshpatel317/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t durgeshpatel317/multi-worker:latest -t durgeshpatel317/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push durgeshpatel317/multi-client:latest
docker push durgeshpatel317/multi-server
docker push durgeshpatel317/multi-worker

docker push durgeshpatel317/multi-client:$SHA
docker push durgeshpatel317/multi-server:$SHA
docker push durgeshpatel317/multi-worker:$SHA

kubectl apply -f ./k8s/
kubectl set image deployments/client-deployment client=durgeshpatel317/multi-client:$SHA
kubectl set image deployments/server-deployment server=durgeshpatel317/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=durgeshpatel317/multi-worker:$SHA
