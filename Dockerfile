FROM tomcat:9.0-jdk17

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file as ROOT (so it runs at / not /KotaShop)
COPY KotaShop.war /usr/local/tomcat/webapps/ROOT.war

# Extract the WAR
RUN cd /usr/local/tomcat/webapps && unzip -q ROOT.war -d ROOT && rm ROOT.war

# Copy your images folder
COPY images /usr/local/tomcat/webapps/ROOT/images

# Tomcat listens on 8080 by default, Render maps its PORT to 8080
EXPOSE 8080

CMD ["catalina.sh", "run"]