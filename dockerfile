FROM --platform=linux/amd64 tomcat:9.0.82-jdk11-openjdk

COPY student-survey-form.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
