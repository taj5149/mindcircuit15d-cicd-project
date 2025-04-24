FROM maven AS buildstage
RUN mkdir /opt/mindcircuit15d-cicd-project
WORKDIR /opt/mindcircuit15d-cicd-project
COPY . .
RUN mvn clean install    ## artifact -- .war 

## tomcat deploy stage 
FROM tomcat 
WORKDIR webapps 
COPY --from=buildstage /opt/mindcircuit15d-cicd-project/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
