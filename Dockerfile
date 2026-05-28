FROM payara/server-web:6.2024.4-jdk17

# Copy the application and images
COPY KotaShop.war ${DEPLOY_DIR}
COPY images ${DEPLOY_DIR}/images

# IMPORTANT: Set the deployment context root to match your expected path
ENV DEPLOY_CONTEXT_ROOT=KotaShop

# Configure Payara to bind to 0.0.0.0 and use Render's PORT
ENV PAYARA_ARGS="--domainConfig --domainName=domain1 --host=0.0.0.0 --port=${PORT:-8080}"

EXPOSE 8080
