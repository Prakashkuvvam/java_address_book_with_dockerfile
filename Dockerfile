FROM maven:amazoncorretto as first
COPY . ./devops
WORKDIR devops/
RUN mvn package

FROM tomee:webprofile
#COPY --from=first /devops/target/addressbook.war /usr/local/tomee/webapps/
COPY --from=first /devops/target/addressbook.war /usr/local/tomee/webapps/ROOT.war