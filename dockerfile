FROM --platform=linux/amd64 tomcat:9.0.82

COPY form.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]