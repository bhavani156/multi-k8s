docker build -t bpurvam/multi-client:latest -t bpurvam/multi-client:$SHA -f ./client/Docker ./client
docker build -t bpurvam/multi-server:latest -t bpurvam/multi-server:$SHA -f ./server/Docker ./server
docker build -t bpurvam/multi-worker:latest -t bpurvam/multi-worker:$SHA -f ./worker/Docker ./worker

docker push bpurvam/multi-client:latest
docker push bpurvam/multi-server:latest
docker push bpurvam/multi-worker:latest

docker push bpurvam/multi-client:$SHA
docker push bpurvam/multi-server:$SHA
docker push bpurvam/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bpurvam/multi-client:$SHA
kubectl set image deployments/server-deployment server=bpurvam/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bpurvam/multi-worker:$SHA