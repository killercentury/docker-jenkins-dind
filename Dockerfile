FROM jpetazzo/dind
MAINTAINER Decheng Zhang <killercentury@gmail.com>

RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-get update && apt-get install -y curl zip supervisor jenkins && rm -rf /var/lib/apt/lists/*
RUN usermod -a -G docker jenkins
ENV JENKINS_HOME /var/lib/jenkins

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME /var/lib/jenkins
EXPOSE 8080

CMD ["/usr/bin/supervisord"]