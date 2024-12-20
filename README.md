# Growth Engineering Technical Assessment

This repository demonstrates the ability to quickly stand up and tear down a demo-ready Kubernetes environment to show a small Golang API to a customer.

## Original Instructions

The original instructions provided by the hiring manager are preserved in `ORIGINAL_README.md` for reference.

## Prerequisites

- A working Kubernetes environment. For this assessment, Docker Desktop's built-in Kubernetes was used.
- Docker installed and running.
- Internet access to push and pull images from ttl.sh
- Optional: `make` (if using the Makefile approach), Helm (if testing Helm deployment).

Kubernetes "flavor" used in submission: **Docker Desktop Kubernetes**

**Note:** No external managed services (like EKS, AKS, etc.) are required. The application and all necessary components run locally.

## Overview

The provided application is a simple Golang HTTP server that was left unchanged:

- Serves on `0.0.0.0:8080`.
- Provides a health endpoint at `/healthz` returning `ok`.
- Provides a version endpoint at `/version`.
- Greets users at `/`, optionally by name.

The repository updates include multiple ways to build, deploy, and tear down the application:

1. **Makefile Based:**

   - **Deploy:** `make deploy`
   - **Teardown:** `make teardown`

2. **Bash Scripts Based (No Make Required):**

   - **Deploy:** `./scripts/deploy.sh`
   - **Teardown:** `./scripts/teardown.sh`

3. **Helm Chart Based (Requires Helm):**
   - **Deploy:**
     ```bash
     docker build -t ttl.sh/growth-engineering:2h ./app
     docker push ttl.sh/growth-engineering:2h
     helm install growth-engineering ./chart
     ```
   - **Teardown:**
     ```bash
     helm uninstall growth-engineering
     ```

All three methods produce the same outcome: a running Golang application accessible within the cluster.

## Recommended Instructions for Evaluators

Follow these steps to replicate and validate the environment setup and teardown.

### 1. Start Fresh (Optional but Recommended)

Before testing a given method, ensure your cluster is clean:

```bash
helm uninstall growth-engineering || true
kubectl delete -f ./app/manifest.yaml || true
```

This ensures no previous deployments conflict with your test.

### 2. Using the Makefile

**Deploy:**

```bash
make deploy
```

This command builds and pushes the Docker image to `ttl.sh`, then applies `app/manifest.yaml` to your cluster.

**Verify Running State:**

```bash
kubectl get pods
kubectl port-forward svc/growth-engineering-service 8080:8080 &
curl http://localhost:8080/healthz
# Expect "ok"
```

**Teardown:**

```bash
make teardown
```

This deletes all Kubernetes resources applied. Confirm with `kubectl get pods`—there should be none remaining.

### 3. Using Bash Scripts

From the project root:

**Deploy:**

```bash
./scripts/deploy.sh
```

This script:

- Builds and pushes the image.
- Applies the manifests.
- Waits for the Pods to become ready.
- Checks health and prints a formatted summary with colors and separators.

**Verify:**
The Bash script will conduct health checks of its own, but if independent verification is desired, the same commands from above can be used:

```bash
kubectl get pods
kubectl port-forward svc/growth-engineering-service 8080:8080 &
curl http://localhost:8080/healthz
# Expect "ok"
```

**Teardown:**

```bash
./scripts/teardown.sh
```

This removes the deployed resources. Check with `kubectl get pods` to confirm.

### 4. Using Helm

If you have Helm installed, you can use the provided chart for a more parameterized and maintainable approach.

**Deploy:**

```bash
docker build -t ttl.sh/growth-engineering:2h ./app
docker push ttl.sh/growth-engineering:2h
helm install growth-engineering ./chart
```

**Verify:**

```bash
kubectl get pods
kubectl port-forward svc/growth-engineering 8080:8080 &
curl http://localhost:8080/healthz
# Expect "ok"
```

**Teardown:**

```bash
helm uninstall growth-engineering
```

Check `kubectl get pods` to ensure the cluster is clean.

## Deliverables

- [x] Updated README with instructions.
- [x] A single command to build and deploy (e.g., `make deploy` or `./scripts/deploy.sh`).
- [x] A single command to teardown (e.g., `make teardown` or `./scripts/teardown.sh`).

## Submission

As requested, a .tar.gz of the entire repository (including .git/ directory) will be emailed to the hiring manager. The updated code is also available on [my personal GitHub repository](https://github.com/CouncilFox/growth_engineering_technical_assessment)

This repository URL will also be included in the submission email for convenience.
