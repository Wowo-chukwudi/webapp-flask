# Deploying a Secure Flask WebApp Project with Github Actions 

This is a simple Flask web application that displays "Hello, World!" It is containerized using Docker, deployed on a KinD Kubernetes cluster, and integrated with a CI/CD pipeline using GitHub Actions to automate the build, test, and deployment processes.

---

## Table of Contents
- [1. Running and Deploying the Project Locally](#1-running-and-deploying-the-project-locally)
- [2. Project Summary](#2-project-summary)

---

## 1. Running and Deploying the Project Locally

### Prerequisites
- **Docker**: Ensure Docker is installed and running on your machine. Download it from [Docker's official website](https://www.docker.com/get-started).
- **KinD (Kubernetes in Docker)**: Install KinD by following the instructions in the [KinD documentation](https://kind.sigs.k8s.io/docs/user/quick-start/).

### Steps to Run Locally

1. **Clone the Repository**:
```bash
   git clone https://github.com/Wowo-chukwudi/webapp-flask.git
   cd webapp-flask
```
2. **Build the Docker Image**:
```bash
docker build -t webapp-flask .
```
3. **Create KinD cluster**:
```bash
kind create cluster --name webapp-flask
```
4. **Deploy to Kubernetes**:
```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
5. **Access the Webapp**: Since the service is of type ClusterIP, it is only accessible within the Kubernetes cluster. To access it locally, use port forwarding:
```bash
kubectl port-forward service/webapp-service 8080:80
```
6. **Open Webappp**:
```bash
http://localhost:8080
```

---

## 2. Project Summary
**About the API**
The API is a simple Flask web application that serves basic HTTP requests. It has a root route (/) that responds with a "Hello, World!" message. The API can be extended to include additional routes and functionality as required.
  - **Base URL: http://localhost:8080**
  - **Endpoint: / (GET)**

**How the API Was Containerized**
The API was containerized using Docker, enabling it to run consistently across different environments. The Dockerfile defines the following:

  - Base Image: The python:3.13-rc-alpine3.20 image is used for minimal size and security.
  - Dependencies: Python dependencies, including Flask, are installed with pip.
  - Security: The application is run as a non-root user (myapp) to avoid privilege escalation risks.
  - Entrypoint: The Flask application runs on 0.0.0.0:8080, making it accessible from any network interface inside the container.

**CI/CD Process**
The CI/CD pipeline is set up using GitHub Actions, which automates the building, testing, and deployment process with the following stages on every push or pull request made to the master branch:

  - Build: Builds the Docker image and pushes it to Docker Hub.
  - Test: Placeholder for future test automation.
  - Deploy: After successful builds, the pipeline deploys the application to a Kubernetes cluster (KinD) and the Kubernetes manifests (deployment.yaml and service.yaml) are applied to deploy the application.
  - Verification: For the final step, the pipeline verifies that the pods have been created.

**Deploying the API to Kubernetes**
The API is deployed on a Kubernetes cluster running in Docker (KinD) using the provided Kubernetes manifests:

  - deployment.yaml: Defines how the application is deployed (3 replicas, webapp-flask image, etc.).
  - service.yaml: Exposes the application to the network. It is a **ClusterIP** so it exposes the application within the Kubernetes cluster, making it accessible only from within the cluster.

    To access the application:

    Use port forwarding for local access when deployed to KinD
    ```bash
    kubectl port-forward service/webapp-service 8080:80
    ```

**Security Measures**
Security Measures Implemented
The following basic security measures have been implemented to ensure the safety and integrity of the application:

  1. Non-root User: The Flask app runs as a non-root user inside the container to prevent privilege escalation.
  2. Minimal Base Image: The application uses an Alpine-based image to minimize its attack surface.
  3. Secrets Management: Sensitive data, such as Docker login credentials are not hard-coded and displayed to be seen but are stored in the repo secrets