FROM quay.io/openshift/origin-jenkins-agent-maven:4.4.0


# Install Java and Maven
RUN INSTALL_PKGS="java-11-openjdk.x86_64" && \
    curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
    curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \
    yum $DISABLES install -y $INSTALL_PKGS
    
#RUN mvn -version
RUN java -version
# Google Chrome
#RUN yum -y --setopt=tsflags=nodocs update && \
 # yum -y --setopt=tsflags=nodocs install socat && \
 # yum -y --setopt=tsflags=nodocs install wget && \
 # yum -y --setopt=tsflags=nodocs install git && \
 # yum -y --setopt=tsflags=nodocs install tmux && \
 # wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
 # yum -y install ./google-chrome-stable_current_x86_64.rpm
