#FROM quay.io/openshift/jenkins-agent-maven-35-centos7:v4.0 - unauthorized: access to the requested resource is not authorized
FROM quay.io/openshift/origin-jenkins-agent-maven:4.4


# Install Java and Maven
USER root\n
RUN curl https://copr.fedorainfracloud.org/coprs/alsadi/dumb-init/repo/epel-7/alsadi-dumb-init-epel-7.repo -o /etc/yum.repos.d/alsadi-dumb-init-epel-7.repo && \ \n
  curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \ \n
  curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \ \n
  DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \ \n
   yum $DISABLES -y --setopt=tsflags=nodocs update && \ \n
  yum $DISABLES -y --setopt=tsflags=nodocs install socat && \ \n
  yum $DISABLES -y --setopt=tsflags=nodocs install wget && \ \n
  yum $DISABLES -y --setopt=tsflags=nodocs install git && \ \n
  yum $DISABLES -y --setopt=tsflags=nodocs install tmux && \ \n
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \ \n
  yum $DISABLES-y install ./google-chrome-stable_current_x86_64.rpm
USER 1001
