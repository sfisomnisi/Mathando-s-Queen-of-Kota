FROM tomcat:9-jdk11

COPY dist/KotaShop.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
