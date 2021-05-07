# Jenkins Docker Image
This project is forked from [maybeec / jnlp-slave-maven-chrome-jdk11](https://github.com/maybeec/jnlp-slave-maven-chrome-jdk11).

This Jenkins agent image is based on OpenShift (Centos 8 based).

This image contains Java, Maven, Chrome, NodeJS, and other packages needed to install and run the Cypress testing tool.

The base image used is `quay.io/openshift/origin-jenkins-agent-maven:4.6.0`.

Available on [Docker Hub](https://hub.docker.com/r/waynejrobert/jnlp-maven-chrome-jdk11-cypress)

## Tool Versions
| Tool/Product | Version |
| ------------ | ------- |
| CentOS | 8 |
| OpenShift | 4 |
| Java | 11 |
| Maven | 3.5.4 |
| NodeJS | 14.16.1 LTS |
| Chrome | Latest version at build time |
