FROM quay.io/openshift/origin-jenkins-agent-maven:4.2.0

USER root

ENV HOME=/home/jenkins \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

USER root
# Install headless Java
RUN curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
    curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    INSTALL_PKGS="bc gettext git java-11-openjdk-headless lsof rsync tar unzip which zip bzip2 jq" && \
    DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \
    yum $DISABLES install -y --setopt=tsflags=nodocs --disableplugin=subscription-manager epel-release && \
    yum $DISABLES install -y --setopt=tsflags=nodocs --disableplugin=subscription-manager $INSTALL_PKGS && \
    rpm -V  $INSTALL_PKGS && \
    yum clean all && \
    mkdir -p /home/jenkins && \
    chown -R 1001:0 /home/jenkins && \
    chmod -R g+w /home/jenkins && \
    chmod -R 775 /etc/alternatives && \
    chmod -R 775 /var/lib/alternatives && \
    chmod -R 775 /usr/lib/jvm && \
    chmod 775 /usr/bin && \
    chmod 775 /usr/lib/jvm-exports && \
    chmod 775 /usr/share/man/man1 && \
    mkdir -p /var/lib/origin && \
    chmod 775 /var/lib/origin && \    
    unlink /usr/bin/java && \
    unlink /usr/bin/jjs && \
    unlink /usr/bin/keytool && \
    unlink /usr/bin/pack200 && \
    unlink /usr/bin/rmid && \
    unlink /usr/bin/rmiregistry && \
    unlink /usr/bin/unpack200 && \
    unlink /usr/lib/jvm-exports/jre && \
    unlink /usr/share/man/man1/java.1.gz && \
    unlink /usr/share/man/man1/jjs.1.gz && \
    unlink /usr/share/man/man1/keytool.1.gz && \
    unlink /usr/share/man/man1/pack200.1.gz && \
    unlink /usr/share/man/man1/rmid.1.gz && \
    unlink /usr/share/man/man1/rmiregistry.1.gz && \
    unlink /usr/share/man/man1/unpack200.1.gz



#RUN curl https://copr.fedorainfracloud.org/coprs/alsadi/dumb-init/repo/epel-7/alsadi-dumb-init-epel-7.repo -o /etc/yum.repos.d/alsadi-dumb-init-epel-7.repo && \ 
 # curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
 #curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
 # DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \
 # yum $DISABLES -y --setopt=tsflags=nodocs update && \
 # yum $DISABLES -y --setopt=tsflags=nodocs install wget && \
 # wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
 # yum $DISABLES -y install ./google-chrome-stable_current_x86_64.rpm && \
#  wget http://mirror.centos.org/centos/7/updates/x86_64/Packages/java-11-openjdk-11.0.4.11-1.el7_7.x86_64.rpm && \
#  yum $DISABLES -y install ./java-11-openjdk-11.0.4.11-1.el7_7.x86_64.rpm && \
#  alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.4.11-1.el7_7.x86_64/bin/java && \
 # wget http://mirror.centos.org/centos/7/os/x86_64/Packages/maven-local-3.4.1-11.el7.noarch.rpm && \
 # yum $DISABLES -y install ./maven-local-3.4.1-11.el7.noarch.rpm
    
# for main web interface:
#EXPOSE 8080

USER 1001

#ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.4.11-1.el7_7.x86_64/bin/java

RUN java -version
RUN google-chrome --version
RUN mvn -version
#FROM quay.io/openshift/jenkins-agent-maven-35-centos7:v4.0 - unauthorized: access to the requested resource is not authorized
#FROM quay.io/openshift/origin-jenkins-agent-maven:4.1.0
