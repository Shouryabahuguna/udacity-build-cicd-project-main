# Udacity Cloud DevOps Engineer - Continuous Integration and Continuous Deployment (CI/CD)

This project demonstrates a production-grade CI/CD pipeline using GitHub Actions, Docker containerization, Kubernetes manifests, and Terraform infrastructure management for a microservices architecture (React Frontend and Python Flask Backend).

---

## Architecture Overview

* **Frontend:** React-based single-page application consuming REST APIs.
* **Backend:** Python Flask application utilizing Pipenv and serving a movie catalog API.
* **Continuous Integration:** GitHub Actions pipelines performing automated linting, unit testing, and artifact builds on each commit.
* **Continuous Deployment:** GitHub Actions pipelines managing container registry builds, tags, and deployment triggers.
* **Infrastructure as Code:** Terraform scripts defining cluster parameters and container runtime setups.

---

## CI/CD Pipelines

### 1. Backend Continuous Integration (`backend-ci.yaml`)
* **Linting:** Flake8 validation for Python code quality and PEP8 standards.
* **Testing:** Pytest execution for API unit tests.
* **Build:** Pipenv dependency resolution and local build verification.

### 2. Frontend Continuous Integration (`frontend-ci.yaml`)
* **Linting:** ESLint verification for code quality and syntax enforcement.
* **Testing:** Jest / React Testing Library unit test suite.
* **Build:** Production bundle compilation via `react-scripts build`.

### 3. Continuous Deployment (`*-cd.yaml`)
* Automated triggers to build Docker container images.
* Image tagging with semantic commit identifiers and pushing to the registry.
* Application orchestration and port binding for microservices communication.

---

## Project Verification & Screenshots

### 1. Continuous Integration Pipelines
* **Frontend CI Workflow Run:**
  ![Frontend CI](screenshots/frontend-ci.png)

* **Backend CI Workflow Run:**
  ![Backend CI](screenshots/backend-ci.png)

### 2. Continuous Deployment Workflows
* **CD Pipeline Executions:**
  ![CD Pipelines](screenshots/cd-pipelines.png)

### 3. Running Microservices (Containers & Application)
* **Active Containers Status (`docker ps`):**
  ![Containers Running](screenshots/containers-running.png)

* **Live Application (Frontend integrated with Backend API):**
  ![Movie App Live](screenshots/movie-app-live.png)

---

## Local Verification Instructions

To execute and verify the application containers locally:

```bash
# Backend Container
cd starter/backend
docker build -t backend:latest .
docker run -d --name backend-app -p 5000:5000 backend:latest

# Frontend Container
cd starter/frontend
docker build -t frontend:latest .
docker run -d --name frontend-app -p 3000:3000 frontend:latest