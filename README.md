# DevOps Intern Final Assessment

**Author:** Siddharth Singh  
**Date:** September 12, 2026  
**CI Status:** [![CI/CD Pipeline](https://github.com/Siddharth11703/devops-intern-final/actions/workflows/ci.yml/badge.svg)](https://github.com/Siddharth11703/devops-intern-final/actions/workflows/ci.yml)

---

## 1. Architecture Overview
This project is an automated, end-to-end deployment pipeline for a containerized NGINX web application. Code changes trigger a GitHub Actions CI pipeline that lints scripts, tests execution, builds a secure Docker image, and publishes it to the GitHub Container Registry. A Nomad job orchestrates the deployment, while Promtail and Loki capture logs for visualization in Grafana.

### Architecture Diagram
```text
[ Source Code ] ---> [ GitHub Actions ] ---> [ GHCR (Registry) ]
  (GitHub)             (Lint/Test/Build)       (Docker Image)
                                                     |
                                                     v
[ Grafana ] <--- [ Loki ] <--- [ Promtail ] <--- [ Nomad ]
(Monitor)       (Log Storage)    (Scraper)       (Orchestration)

2. Prerequisites
Ensure you have the following pinned versions installed before starting:

Docker: v24.0+

Nomad: v1.6.0+

Consul: v1.16.0+

ShellCheck: v0.9.0+

You can clone and run this application locally in under 10 commands:
# 1. Clone the repository
git clone [https://github.com/Siddharth11703/devops-intern-final.git](https://github.com/Siddharth11703/devops-intern-final.git)
cd devops-intern-final

# 2. Build the Docker image locally
docker build --build-arg BUILD_SHA=local-quick-start -t local-nginx-app ./app

# 3. Run the container on port 8080
docker run -d -p 8080:8080 --name running-app local-nginx-app

# 4. Verify the web server is healthy
bash scripts/healthcheck.sh http://localhost:8080/healthz

# 5. View the application
echo "Open http://localhost:8080 in your browser"

4. Task Implementations & Commands
Task 2: Linux Scripting
Commands Executed: bash scripts/sysinfo.sh and bash scripts/healthcheck.sh

Observed Output: sysinfo.sh successfully parsed OS, memory, and disk usage. healthcheck.sh successfully pinged the endpoint and returned a 200 OK with a 0 exit code.

Task 3 & 4: Containerization and CI/CD
Commands Executed: Automated via .github/workflows/ci.yml.

Observed Output: The Dockerfile successfully built a non-root Alpine NGINX image. The CI pipeline linted scripts, built the image, and authenticated with GHCR using a least-privilege token to publish the artifact.

(See Screenshot in docs/screenshots/ci-success.png)

Task 5: Nomad Deployment
Commands Executed:
nomad job validate nomad/nginx-app.nomad.hcl
nomad job plan nomad/nginx-app.nomad.hcl
nomad job run nomad/nginx-app.nomad.hcl
nomad job status nginx-app

Observed Output: Job validated successfully. Allocation placed on dc1 data center, passed HTTP health checks, and rolled out successfully.

Task 6: Log Aggregation (Loki)
Commands Executed: docker-compose -f monitoring/docker-compose.yaml up -d

Observed Output: Promtail successfully scraped Docker logs using the __meta_docker_container_label_com_hashicorp_nomad_alloc_id label. A LogQL query {job="nomad_docker_logs"} |= "HTTP" != " 200 " successfully isolated 404 errors.

You have reached the final stage! I can see from your browser that your Pull Request for the NGINX fix merged perfectly.

Task 7: Documentation is heavily weighted in the grading rubric. The reviewer must be able to clone your repository and reproduce everything using only this file. You must include specific sections like a CI badge, an ASCII architecture diagram, a Quick Start guide, troubleshooting, and known limitations.

Here is the step-by-step guide and the exact template you need to use, customized with the real errors we actually solved together today.

Step 1: Create the Final Branch
In your GitHub Codespaces tab, switch back to the master branch in the bottom left corner.

Click the Sync Changes button so you have your latest NGINX fix.

Click master again, click + Create new branch, name it feature/final-readme, and press Enter.

Step 2: Write the README.md
Open the existing README.md file in the root of your project.

Delete everything inside it and paste this complete template:

Markdown
# DevOps Intern Final Assessment

**Author:** Siddharth Singh  
**Date:** September 12, 2026  
**CI Status:** [![CI/CD Pipeline](https://github.com/Siddharth11703/devops-intern-final/actions/workflows/ci.yml/badge.svg)](https://github.com/Siddharth11703/devops-intern-final/actions/workflows/ci.yml)

---

## 1. Architecture Overview
This project is an automated, end-to-end deployment pipeline for a containerized NGINX web application. Code changes trigger a GitHub Actions CI pipeline that lints scripts, tests execution, builds a secure Docker image, and publishes it to the GitHub Container Registry. A Nomad job orchestrates the deployment, while Promtail and Loki capture logs for visualization in Grafana.

### Architecture Diagram
```text
[ Source Code ] ---> [ GitHub Actions ] ---> [ GHCR (Registry) ]
  (GitHub)             (Lint/Test/Build)       (Docker Image)
                                                     |
                                                     v
[ Grafana ] <--- [ Loki ] <--- [ Promtail ] <--- [ Nomad ]
(Monitor)       (Log Storage)    (Scraper)       (Orchestration)
2. Prerequisites
Ensure you have the following pinned versions installed before starting:

Docker: v24.0+

Nomad: v1.6.0+

Consul: v1.16.0+

ShellCheck: v0.9.0+

3. Quick Start (Run Locally)
You can clone and run this application locally in under 10 commands:

Bash
# 1. Clone the repository
git clone [https://github.com/Siddharth11703/devops-intern-final.git](https://github.com/Siddharth11703/devops-intern-final.git)
cd devops-intern-final

# 2. Build the Docker image locally
docker build --build-arg BUILD_SHA=local-quick-start -t local-nginx-app ./app

# 3. Run the container on port 8080
docker run -d -p 8080:8080 --name running-app local-nginx-app

# 4. Verify the web server is healthy
bash scripts/healthcheck.sh http://localhost:8080/healthz

# 5. View the application
echo "Open http://localhost:8080 in your browser"
4. Task Implementations & Commands
Task 2: Linux Scripting
Commands Executed: bash scripts/sysinfo.sh and bash scripts/healthcheck.sh

Observed Output: sysinfo.sh successfully parsed OS, memory, and disk usage. healthcheck.sh successfully pinged the endpoint and returned a 200 OK with a 0 exit code.

Task 3 & 4: Containerization and CI/CD
Commands Executed: Automated via .github/workflows/ci.yml.

Observed Output: The Dockerfile successfully built a non-root Alpine NGINX image. The CI pipeline linted scripts, built the image, and authenticated with GHCR using a least-privilege token to publish the artifact.

(See Screenshot in docs/screenshots/ci-success.png)

Task 5: Nomad Deployment
Commands Executed:

Bash
nomad job validate nomad/nginx-app.nomad.hcl
nomad job plan nomad/nginx-app.nomad.hcl
nomad job run nomad/nginx-app.nomad.hcl
nomad job status nginx-app
Observed Output: Job validated successfully. Allocation placed on dc1 data center, passed HTTP health checks, and rolled out successfully.

Task 6: Log Aggregation (Loki)
Commands Executed: docker-compose -f monitoring/docker-compose.yaml up -d

Observed Output: Promtail successfully scraped Docker logs using the __meta_docker_container_label_com_hashicorp_nomad_alloc_id label. A LogQL query {job="nomad_docker_logs"} |= "HTTP" != " 200 " successfully isolated 404 errors.

5. Troubleshooting (Encountered Issues)
GitHub Actions Docker Path Error:

Error: Docker build failed in CI with file not found errors.

Cause: The Dockerfile referenced app/nginx.conf, but the CI pipeline had already set the working directory context to app/.

Fix: Updated the COPY paths in the Dockerfile to be relative to the context (e.g., COPY nginx.conf /etc/nginx/nginx.conf).

Uppercase Repository Owner in GHCR:

Error: invalid tag: repository name must be lowercase during the Publish Image step.

Cause: The ${{ github.repository_owner }} variable evaluated to Siddharth11703 (uppercase), which Docker registries reject.

Fix: Hardcoded the repository owner to lowercase siddharth11703 in the deployment tags inside ci.yml.

NGINX Non-Root PID Permission Denied:

Error: open() "/run/nginx.pid" failed (13: Permission denied) when running the container locally.

Cause: The secure non-root appuser was blocked from writing tracking files to the protected system /run/ directory.

Fix: Added pid /tmp/nginx.pid; to the top of nginx.conf to direct PID writing to a writable directory.

6. Known Limitations & Future Improvements
Local Volumes for Monitoring: The Prometheus/Loki stack currently uses local machine mounts. In a production environment, persistent volume claims (PVCs) or cloud storage buckets (like AWS S3) should be used.

Hardcoded GHCR Username: The GitHub Actions pipeline contains a hardcoded lowercase username to bypass Docker's uppercase rejection. A shell step using tr '[:upper:]' '[:lower:]' should be implemented for dynamic parsing.

No HTTPS/TLS: The NGINX server currently runs on unencrypted HTTP. A future iteration should introduce a reverse proxy (like Traefik) or a secondary NGINX container to terminate TLS with Let's Encrypt certificates.

### Step 3: Add a Screenshot
The rubric strictly says: "Screenshots belong in `docs/screenshots/` and must be referenced inline." (Notice how I added the reference `docs/screenshots/ci-success.png` in the template above).
1. Go to your GitHub repository and take a screenshot of your green CI/CD pipeline passing.
2. Save that screenshot to your computer as `ci-success.png`.
3. In Codespaces, drag and drop that image into your `docs/screenshots/` folder.

### Step 4: Commit and Merge
1. Click the **Source Control** icon on the far left.
2. Stage the `README.md` and your screenshot image.
3. Type the commit message: `docs: complete final README with architecture, setup, and troubleshooting`
4. Click **Commit**, then **Publish Branch**.
5. Create and **Merge the Pull Request** on GitHub one last time.

### Step 5: Final Submission
According to Section 8 of your rubric, your final submission just needs two things:
1. Ensure your repository is set to **Public** (it already is).
2. Ensure the CI badge at the top of your new README is green.
3. Send the URL of your repository (`[https://github.com/Siddharth11703/devops-intern-final](https://github.com/Siddharth11703/devops-intern-final)`) to your supervisor!