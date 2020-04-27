FROM quay.io/openshift/origin-jenkins-agent-maven:4.6

USER root

ENV MAVEN_VERSION 3.5.4

RUN  curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
  curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
  DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl --disablerepo=rhel-fast-datapath-beta --disablerepo=rhel-fast-datapath" && \
  yum $DISABLES -y --setopt=tsflags=nodocs update && \
  yum $DISABLES -y --setopt=tsflags=nodocs install wget && \
  yum $DISABLES -y --setopt=tsflags=nodocs install gzip && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
  yum $DISABLES -y install ./google-chrome-stable_current_x86_64.rpm && \
  alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.7.10-4.el7_8.x86_64/bin/java
RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
 # wget http://mirror.centos.org/centos/7/os/x86_64/Packages/maven-local-3.4.1-11.el7.noarch.rpm && \
 # yum $DISABLES --disableplugin=subscription-manager -y install ./maven-local-3.4.1-11.el7.noarch.rpm
    
# for main web interface:
#EXPOSE 8080
ENV maven.home /usr/share/maven
ENV PATH /usr/share/maven/bin

USER 1001

RUN google-chrome --version
RUN java -version
RUN mvn -version
#FROM quay.io/openshift/jenkins-agent-maven-35-centos7:v4.0 - unauthorized: access to the requested resource is not authorized
#FROM quay.io/openshift/origin-jenkins-agent-maven:4.1.0
