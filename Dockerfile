#FROM quay.io/openshift/jenkins-agent-maven-35-centos7:v4.0 - unauthorized: access to the requested resource is not authorized
FROM quay.io/openshift/origin-jenkins-agent-maven:4.4


# Install Java and Maven


RUN DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \ \n
  yum $DISABLES -y --setopt=tsflags=nodocs update && \
  yum $DISABLES -y --setopt=tsflags=nodocs install socat && \
  yum $DISABLES -y --setopt=tsflags=nodocs install wget && \
  yum $DISABLES -y --setopt=tsflags=nodocs install git && \
  yum $DISABLES -y --setopt=tsflags=nodocs install tmux && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
  yum $DISABLES-y install ./google-chrome-stable_current_x86_64.rpm
