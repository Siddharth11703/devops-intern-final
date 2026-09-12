# Loki Log Aggregation Setup

## 1. Starting the Stack
The stack was started using Docker Compose from the `monitoring/` directory:
\`\`\`bash
docker-compose up -d
\`\`\`

## 2. Label Set Applied
Using Promtail's `docker_sd_configs`, we attached the following labels directly from the Docker daemon:
* \`job\`: Hardcoded as `nomad_docker_logs`
* \`container\`: Extracted from the Docker container name
* \`nomad_alloc_id\`: Extracted from Nomad's native Docker labels

## 3. LogQL Queries and Results
To confirm ingestion and isolate NGINX access logs with non-200 status codes (e.g., a 404 error from requesting a missing path), we ran:
\`\`\`logql
{job="nomad_docker_logs"} |= "HTTP" != " 200 "
\`\`\`
**Results:** The query successfully filtered out healthy `/healthz` pings and isolated the 404 Not Found error logs when requesting an invalid path.

## 4. Problems Encountered
**Issue:** Extracting the `nomad_alloc_id` dynamically.
**Resolution:** Used the `__meta_docker_container_label_com_hashicorp_nomad_alloc_id` internal label in Promtail's `relabel_configs` to safely surface it to Grafana.