# Jenkins Docker Image
This project is forked from [maybeec / jnlp-slave-maven-chrome-jdk11](https://github.com/maybeec/jnlp-slave-maven-chrome-jdk11).

This Jenkins agent image is based on OpenShift (Centos 7 based).

This image contains Java, Maven, Chrome, and other packages needed to install and run the Cypress testing tool.

The base image used is `quay.io/openshift/origin-jenkins-agent-maven:4.6.0`.

Available on [Docker Hub](#)

## Tool Versions
| Tool/Product | Version |
| ------------ | ------- |
| Centos | 7 |
| OpenShift | 4 |
| Java | 11 |
| Maven | 3.5.4 |
| Chrome | Latest version at build time |
