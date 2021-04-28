FROM quay.io/openshift/origin-jenkins-agent-maven:4.6

USER root

ENV MAVEN_VERSION 3.6.3
ENV GIT_COMMITTER_NAME Jenkins
ENV GIT_COMMITTER_EMAIL no-reply-jenkins@localhost

RUN  curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
  curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
  DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl --disablerepo=rhel-fast-datapath-beta --disablerepo=rhel-fast-datapath" && \
  yum $DISABLES -y --setopt=tsflags=nodocs update && \
  yum $DISABLES -y --setopt=tsflags=nodocs install wget && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
  yum $DISABLES -y install ./google-chrome-stable_current_x86_64.rpm && \
  alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.7.10-4.el7_8.x86_64/bin/java && \
  curl https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

RUN java -version
RUN google-chrome --version
RUN mvn -version

# Installing pre-requisites for Cypress testing tool
RUN yum $DISABLES -y --setopt=tsflags=nodocs update && \
  yum $DISABLES -y --setopt=tsflags=nodocs install xorg-x11-server-Xvfb && \
  yum $DISABLES -y --setopt=tsflags=nodocs install gtk2-devel && \
  yum $DISABLES -y --setopt=tsflags=nodocs install gtk3-devel && \
  yum $DISABLES -y --setopt=tsflags=nodocs install libnotify-devel && \
  yum $DISABLES -y --setopt=tsflags=nodocs install GConf2 && \
  yum $DISABLES -y --setopt=tsflags=nodocs install nss && \
  yum $DISABLES -y --setopt=tsflags=nodocs install libXScrnSaver && \
  yum $DISABLES -y --setopt=tsflags=nodocs install alsa-lib
