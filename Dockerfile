FROM openshift/jenkins-agent-maven-35-centos7:v4.0
#FROM quay.io/openshift/origin-jenkins-agent-maven:4.4.0


# Install Java and Maven

    
#RUN mvn -version
#RUN java -version
USER root

# Google Chrome
RUN yum -y --setopt=tsflags=nodocs update && \
  yum -y --setopt=tsflags=nodocs install socat && \
  yum -y --setopt=tsflags=nodocs install wget && \
  yum -y --setopt=tsflags=nodocs install git && \
  yum -y --setopt=tsflags=nodocs install tmux && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
  yum -y install ./google-chrome-stable_current_x86_64.rpm

USER 1001

RUN google-chrome --version
