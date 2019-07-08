docker build -t milanunion/multi-client:latest -t milanunion/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t milanunion/multi-server:latest -t milanunion/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t milanunion/multi-worker:latest -t milanunion/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push milanunion/multi-client:latest
docker push milanunion/multi-server:latest
docker push milanunion/multi-worker:latest
docker push milanunion/multi-client:$SHA
docker push milanunion/multi-server:$SHA
docker push milanunion/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=milanunion/multi-client:$SHA
kubectl set image deployments/server-deployment server=milanunion/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=milanunion/multi-worker:$SHA