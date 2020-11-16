docker build -t bpurvam/multi-client -f ./client/Docker ./client
docker build -t bpurvam/multi-server -f ./server/Docker ./server
docker build -t bpurvam/multi-worker -f ./worker/Docker ./worker
docker push bpurvam/multi-client
docker push bpurvam/multi-server
docker push bpurvam/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bpurvam/multi-server