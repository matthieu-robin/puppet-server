FROM centos:centos7
MAINTAINER matthieu-robin

# Environment configuration
ENV PUPPETSERVER_JAVA_ARGS="-Xms2g -Xmx2g -XX:MaxPermSize=256m"

# Update CentOS
RUN yum -y update
RUN yum -y install wget git

# Install NTP
RUN timedatectl list-timezones
RUN timedatectl set-timezone Europe/Paris
RUN yum -y install ntp
RUN ntpdate pool.ntp.org
RUN systemctl restart ntpd
RUN systemctl enable ntpd

# Install Puppet Server
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum -y install puppetserver
RUN systemctl start puppetserver
RUN systemctl enable puppetserver
