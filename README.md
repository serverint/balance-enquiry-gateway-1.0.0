# WASP Switch BALANCE ENQUIRY GATEWAY
module for retrieving account balance from the bank.
With targetAccountNumber and instructedInstitutionCode, the 
service contacts the institution via the institution's API to 
retrieve the balance of the targetAccountNumber. 

## Installation instructions
Build a docker image from [here](./Dockerfile)
```
docker build -t wasp/balance-enquiry-gateway .
```
Start a docker container from the image
```
docker run -it -d -p 9031:8080 \
-v /etc/timezone:/etc/timezone \
-v /home/teamcity/apps_properties/wasp_balance_enquiry_gateway:/properties/ \
-v /home/teamcity/apps_logs/wasp_balance_enquiry_gateway:/var/log/ \
--name wasp-balance-enquiry-gateway wasp/balance-enquiry-gateway
```
Default properties are the following. If you want to override some or all default properties create a property file with the parameters you want to override and run the java jar with this environment property ```--spring.config.location=/properties/application.properties```.
```
spring.application.name=balance-enquiry-gateway
server.port=8080
#Kafka
spring.cloud.stream.bindings.output.destination=logs
spring.cloud.stream.bindings.output.contentType=application/json
spring.cloud.stream.bindings.output.group=logs-group
spring.cloud.stream.kafka.binder.brokers=192.168.101.6
spring.cloud.stream.kafka.binder.zkNodes=192.168.101.6
spring.cloud.stream.kafka.binder.autoAddPartitions=true
#Registry
eureka.client.service-url.defaultZone= http://192.168.101.6:9010/eureka/
eureka.instance.prefer-ip-address=true
eureka.instance.ip-address=192.168.101.6 //docker's ip
eureka.instance.non-secure-port=9022 // docker's mapped port
eureka.instance.metadataMap.instanceId=${spring.application.name}:9022
#Zipkin
spring.zipkin.enabled=true
spring.zipkin.baseUrl=http://192.168.101.6:9012
#LOGGING
logging.level.root=INFO
logging.level.org.springframework.web=INFO
logging.level.org.hibernate=INFO
```
