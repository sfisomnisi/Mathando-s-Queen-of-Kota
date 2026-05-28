FROM payara/server-web:6.2024.4-jdk17

COPY KotaShop.war ${DEPLOY_DIR}

COPY images ${DEPLOY_DIR}/images

EXPOSE 8080