FROM quay.io/openshift/origin-jenkins-agent-maven:4.6

USER root

ENV MAVEN_VERSION 3.6.3
ENV GIT_COMMITTER_NAME Jenkins
ENV GIT_COMMITTER_EMAIL no-reply-jenkins@localhost
ENV DISABLES "--disablerepo=rhel-8-baseos --disablerepo=rhel-8-appstream --disablerepo=rhel-8-server-ose --disablerepo=rhel-8-fast-datapath --disablerepo=rhel-8-ansible-2.9 --disablerepo=openstack-16-for-rhel-8-rpms --disablerepo=rhel-8-codeready-builder-rpms"

# Add CentOS repos
COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN curl http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-Official -o /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
RUN yum $DISABLES -y --setopt=tsflags=nodocs update
# Install wget
RUN yum $DISABLES -y --setopt=tsflags=nodocs install wget
# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
  yum $DISABLES -y install ./google-chrome-stable_current_x86_64.rpm
# Install Firefox
RUN yum $DISABLES -y --setopt=tsflags=nodocs install firefox
# Install Edge
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
  dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge && \
  mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-dev.repo && \
  dnf $DISABLES -y --setopt=tsflags=nodocs install microsoft-edge-dev
 
# Install Java
RUN alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.11.0.9-0.el8_3.x86_64/bin/java
# Install Maven
RUN curl https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -sf /usr/share/maven/bin/mvn /usr/bin/mvn

# Installing pre-requisites for Cypress testing tool
RUN yum $DISABLES -y --setopt=tsflags=nodocs install xorg-x11-server-Xvfb
RUN yum $DISABLES -y --setopt=tsflags=nodocs install gtk2-devel
RUN yum $DISABLES -y --setopt=tsflags=nodocs install gtk3-devel
RUN yum $DISABLES -y --setopt=tsflags=nodocs install libnotify-devel
RUN yum $DISABLES -y --setopt=tsflags=nodocs install GConf2
RUN yum $DISABLES -y --setopt=tsflags=nodocs install nss
RUN yum $DISABLES -y --setopt=tsflags=nodocs install libXScrnSaver
RUN yum $DISABLES -y --setopt=tsflags=nodocs install alsa-lib

# Installing pre-requisites for building npm modules
RUN yum $DISABLES -y --setopt=tsflags=nodocs install gcc-c++ 
RUN yum $DISABLES -y --setopt=tsflags=nodocs install make

# Install NodeJS latest LTS version (Currently 14)
RUN dnf module $DISABLES -y --setopt=tsflags=nodocs install nodejs:14

#Validate installs
RUN java -version
RUN google-chrome --version
RUN mvn -version
RUN node --version
RUN npm -version
