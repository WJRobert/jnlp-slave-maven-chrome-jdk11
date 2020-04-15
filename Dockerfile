FROM quay.io/openshift/origin-jenkins-agent-base:v4.0

ENV MAVEN_VERSION=3.5 \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable" \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    MAVEN_OPTS="-Duser.home=$HOME"
# TODO: Remove MAVEN_OPTS env once cri-o pushes the $HOME variable in /etc/passwd

# Install Maven
RUN INSTALL_PKGS="java-11-openjdk-devel.x86_64 java-1.8.0-openjdk-devel.x86_64 maven*" && \
    curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
    curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \
    yum $DISABLES install -y $INSTALL_PKGS && \
    rpm -V java-11-openjdk-devel.x86_64 java-1.8.0-openjdk-devel.x86_64 maven && \
    yum clean all -y && \
    mkdir -p $HOME/.m2 
    
# Google Chrome
RUN yum -y --setopt=tsflags=nodocs update && \
  yum -y --setopt=tsflags=nodocs install socat && \
  yum -y --setopt=tsflags=nodocs install wget && \
  yum -y --setopt=tsflags=nodocs install git && \
  yum -y --setopt=tsflags=nodocs install tmux && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
  yum -y install ./google-chrome-stable_current_x86_64.rpm
