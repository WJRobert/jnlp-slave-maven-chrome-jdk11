FROM quay.io/openshift/origin-jenkins-agent-maven:4.2.0
USER root
RUN curl https://copr.fedorainfracloud.org/coprs/alsadi/dumb-init/repo/epel-7/alsadi-dumb-init-epel-7.repo -o /etc/yum.repos.d/alsadi-dumb-init-epel-7.repo && \ 
  curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
  curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
  DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \
  yum $DISABLES -y --setopt=tsflags=nodocs update && \
  yum $DISABLES -y --setopt=tsflags=nodocs install wget && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
  yum $DISABLES -y install ./google-chrome-stable_current_x86_64.rpm && \
  wget http://mirror.centos.org/centos/7/updates/x86_64/Packages/java-11-openjdk-11.0.4.11-1.el7_7.x86_64.rpm && \
  yum $DISABLES -y install ./java-11-openjdk-11.0.4.11-1.el7_7.x86_64.rpm && \
  alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.4.11-1.el7_7.x86_64/bin/java && \ 
  alternatives --set jre /usr/lib/jvm/jre-11-openjdk-11.0.4.11-1.el7_7.x86_64/bin/java && \
  wget http://mirror.centos.org/centos/7/os/x86_64/Packages/maven-local-3.4.1-11.el7.noarch.rpm && \
  yum $DISABLES -y install ./maven-local-3.4.1-11.el7.noarch.rpm 
  
RUN echo 'starting jenkins'
RUN yum service jenkins start
RUN yum service jenkins status
USER 1001

#ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.4.11-1.el7_7.x86_64/bin/java

RUN java -version
RUN google-chrome --version
RUN mvn -version
#FROM quay.io/openshift/jenkins-agent-maven-35-centos7:v4.0 - unauthorized: access to the requested resource is not authorized
#FROM quay.io/openshift/origin-jenkins-agent-maven:4.1.0
