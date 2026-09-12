# 1. Base the image on a pinned tag (not 'latest')
FROM nginx:1.27-alpine

# 2. Accept the BUILD_SHA build argument
ARG BUILD_SHA
ENV BUILD_SHA=$BUILD_SHA

# 3. Create a non-root user
RUN adduser -D -H -u 10000 -s /bin/nologin appuser

# 4. Set up directories and permissions for the non-root user
RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx && \
    chown -R appuser:appuser /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html /etc/nginx/

# 5. Switch to the non-root user for security
USER appuser

# 6. Copy our custom NGINX config and HTML file into the container
COPY --chown=appuser:appuser app/nginx.conf /etc/nginx/nginx.conf
COPY --chown=appuser:appuser app/index.html /usr/share/nginx/html/index.html

# 7. Replace the placeholder in the HTML with the actual BUILD_SHA
RUN sed -i "s/\${BUILD_SHA}/${BUILD_SHA}/g" /usr/share/nginx/html/index.html

# 8. Declare the port and healthcheck
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:8080/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]