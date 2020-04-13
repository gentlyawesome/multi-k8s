docker build -t gentlyawesome/multi-client:latest -t gentlyawesome/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gentlyawesome/multi-server:latest -t gentlyawesome/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gentlyawesome/multi-worker:latest -t gentlyawesome/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gentlyawesome/multi-client:latest
docker push gentlyawesome/multi-server:latest
docker push gentlyawesome/multi-worker:latest

docker push gentlyawesome/multi-client:$SHA
docker push gentlyawesome/multi-server:$SHA
docker push gentlyawesome/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=gentlyawesome/multi-server:$SHA
kubectl set image deployments/client-deployment client=gentlyawesome/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gentlyawesome/multi-worker:$SHA
