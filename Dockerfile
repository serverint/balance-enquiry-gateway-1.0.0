FROM frolvlad/alpine-oraclejdk8:slim
MAINTAINER "A.Odunlami <debo.odunlami@arca.network>"
# Define working directory.
WORKDIR /work
ADD target/balance-enquiry-gateway-0.0.1-SNAPSHOT.jar /work/balance-enquiry-gateway-0.0.1-SNAPSHOT.jar
# Expose Ports
EXPOSE 9031

ENTRYPOINT exec java $JAVA_OPTS -jar /work/balance-enquiry-gateway-0.0.1-SNAPSHOT.jar --spring.config.location=/properties/application.properties