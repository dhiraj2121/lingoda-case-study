# Lingoda Case Study
<br />

## Solution Description and rationals:

For the given case study, created one click solution to deploy application locally using different DevOps tools.

### 1. Local Kubernetes cluster:
`Current Implementation`:
- Used Kind to create local multi node kubernetes cluster for deploying application and database.

`Industry Standard Implementation`:
- Usually we use cloud provided kubernetes services to host our application with ingress controllers or service mesh.

### 2. Symfony app and Database Migration:
`Current Implementation`:
- Used sample symfony demo application which has mysql database connectivity.
- Docker image for Symfony and nginx will be created and will be loaded to the kind cluster.
- For migration of database, created init container which will run migration script before deployment of application and used Doctrine tool to do the migration and then application deployment will start for new version.
- Added standard practices to verify application state provided by the k8s Deployment template.
- Application is exposed withing a cluster using nginx and k8s service template.

`Industry Standard Implementation`:
- Usually we push docker images to any private docker registry.
- To expose application to internet from k8s cluster usually LoadBalancer as a service, ingress or service mesh is used.

### 3. Autoscaling:
`Current Implementation`:
- Used Horizontal Pod Autoscaling(HPA) to autoscale pods based on CPU and memory usage.
- Used metrics server to get the CPU and memory metrics from the pods and cluster.

`Industry Standard Implementation`:
- We should use custom metrics(like http_requests) from application along with the CPU and memory resource metrics for autoscaling.
- And to get the custom metrics we can use Prometheus and Prometheus operator along with the ServiceMonitor to screp the metrics from pod and then we can use Prometheus adapter to register these metrics to the kubernetes api so that custom metrics can be used in HPA.

<br />
<br />

## Let's jump into an action!

For deployment of an application, below pre-requisites of the tools will require and then just run Taskfile command. Steps are given below:

### 1. Pre-requisites:
- Docker: [[install-docker]](https://docs.docker.com/engine/install/)
- Kind: [[install-kind]](https://kind.sigs.k8s.io/docs/user/quick-start/)
- Helm: [[install-helm]](https://helm.sh/docs/intro/install/)

### 2. Clone repository:

```
git clone git@github.com:dhiraj2121/lingoda-case-study.git
```

### 3. Run below task command to create cluster and to deploy symfony application:
```
task create-cluster switch-context php-docker-image nginx-docker-image load-dockerimage deploy-metric-server deploy-symfony-app
```
Task commands will perform following tasks:
1. Create kubernetes multi node cluster using Kind.
2. Create Docker image for symfony and nginx.
3. Load both Docker images(symfony and nginx) into Kind cluster.
4. Deploy metrics server and Symfony application along with the mysql database using helm charts.

taskfile commands are present in `taskfile.yaml`.

### 4. Test application:

Check application and database pods are created successfully.
```
kubectl get pods
```
Check HPA is created successfully.
```
kubectl get hpa
```
Run below command to expose symfony application locally.
```
 kubectl port-forward service/symfony-app 8080:80
```
Go to the browser and paste below url. Application should be up and running!
```
http://localhost:8080/articles
```