#FROM quay.io/openshift/jenkins-agent-maven-35-centos7:v4.0 - unauthorized: access to the requested resource is not authorized
FROM quay.io/openshift/origin-jenkins-agent-maven:4.4


# Install Java and Maven

    
# List installed and available packages from repositories:
RUN yum list all
# List only installed packages:
RUN yum list installed
# List only available packages:
RUN yum list available
# List installed and available kernel packages:
RUN yum list kernel
