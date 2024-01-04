 FROM maven:3.8.6-openjdk-11 as build
 ARG BRANCH=main
 RUN git clone https://github.com/srinudammalapati/spring-petclinic.git && \
     cd spring-petclinic && \
     git checkout ${BRANCH} && \  
     mvn package    

     # jar location /spring-petclinic/target/spring-petclinic-2.7.3.jar 


FROM openjdk:11
LABEL author="srinu"
LABEL project="springpetclinic"
COPY --from=build /spring-petclinic/target/spring-petclinic-2.7.3.jar /spring-petclinic-2.7.3.jar 
EXPOSE 8080
CMD [ "java", "-jar", "/spring-petclinic-2.7.3.jar" ]