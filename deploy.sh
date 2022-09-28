docker build -t mmgc84/multi-client:latest -t mmgc84/multi-client:$SHA -f ./client/Dockerfile ./client/
docker build -t mmgc84/multi-server:latest -t mmgc84/multi-server:$SHA -f ./server/Dockerfile ./server/
docker build -t mmgc84/multi-worker:latest -t mmgc84/multi-worker:$SHA -f ./worker/Dockerfile ./worker/

docker push mmgc84/multi-client:latest
docker push mmgc84/multi-server:latest
docker push mmgc84/multi-worker:latest

docker push mmgc84/multi-client:$SHA
docker push mmgc84/multi-server:$SHA
docker push mmgc84/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=mmgc84/multi-client:$SHA
kubectl set image deployments/server-deployment server=mmgc84/multi-server:$SHA
kubectl set image deployments/worker-deployment worker==mmgc84/multi-worker:$SHA