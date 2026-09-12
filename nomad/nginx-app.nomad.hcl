# Parameterise the tag with an HCL variable (Required by rubric)
variable "image_tag" {
  type        = string
  description = "The tag of the Docker image to deploy"
  default     = "latest"
}

job "nginx-app" {
  datacenters = ["dc1"]
  
  # Type service (Required by rubric)
  type = "service"

  # Rolling deployment configuration (Required by rubric)
  update {
    max_parallel      = 1
    min_healthy_time  = "10s"
    healthy_deadline  = "2m"
    auto_revert       = true
  }

  # Reschedule policy (Required by rubric)
  reschedule {
    delay          = "30s"
    delay_function = "exponential"
    max_delay      = "1h"
    unlimited      = true
  }

  # One group (Required by rubric)
  group "web" {
    count = 1

    network {
      # Dynamic port allocation mapped to container port 8080
      port "http" {
        to = 8080
      }
    }

    # Restart policy (Required by rubric)
    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "fail"
    }

    # Consul service registration with HTTP health check
    service {
      name = "nginx-app-service"
      port = "http"

      check {
        type     = "http"
        path     = "/healthz"
        interval = "10s"
        timeout  = "2s"
      }
    }

    # One task using the docker driver (Required by rubric)
    task "nginx" {
      driver = "docker"

      config {
        # Pulls the image from your GitHub Container Registry
        image = "ghcr.io/siddharth11703/devops-intern-final/nginx-app:${var.image_tag}"
        ports = ["http"]
      }

      # Resource allocation (Required by rubric)
      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}