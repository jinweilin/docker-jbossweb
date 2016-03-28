FROM jinweilin/java:1.7.0_79

ENV CATALINA_HOME /usr/local/jboss-web
ENV PATH $CATALINA_HOME/bin:$PATH
ENV JBOSSWEB_TGZ_URL http://downloads.jboss.org/jbossweb/2.1.9.GA/jboss-web-2.1.9.GA.tar.gz

RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    echo 'Asia/Taipei' > /etc/timezone && date && \ 
		sed -e 's;UTC=yes;UTC=no;' -i /etc/default/rcS && \
		echo "!/bin/sh ntpdate ntp.ubuntu.com" >> /etc/cron.daily/ntpdate && \
    chmod 750 /etc/cron.daily/ntpdate && \
		mkdir -p "$CATALINA_HOME" && \
		mkdir -p "/opt/war" && \
		mkdir -p "/home/art" && \
		apt-get update && \
		apt-get install -y curl && \
		apt-get clean && \
		set -x && \
		curl -f "$JBOSSWEB_TGZ_URL" -o jboss-web.tar.gz && \
		tar -xvf jboss-web.tar.gz --strip-components=1 && \
		rm bin/*.bat && \
		rm jboss-web.tar.gz*

WORKDIR $CATALINA_HOME

COPY jt400-6.6.jar /usr/local/jboss-web/lib/jt400-6.6.jar
COPY edb-jdbc16.jar /usr/local/jboss-web/lib/edb-jdbc16.jar
COPY kaiu.ttf /usr/local/jboss-web/lib/kaiu.ttf
COPY mysql-connector-java-5.1.19-bin.jar /usr/local/jboss-web/lib/mysql-connector-java-5.1.19-bin.jar
COPY server.xml /usr/local/jboss-web/conf/server.xml
COPY tomcat-users.xml /usr/local/jboss-web/conf/tomcat-users.xml
VOLUME ["/usr/local/jboss-web/logs","/opt/war","/home/art"]

#RUN ["rm", "-fr", "$CATALINE_HOME/webapps/ROOT"]
#RUN ["rm", "-fr", "$CATALINE_HOME/webapps/docs"]

EXPOSE 8080
EXPOSE 8009

CMD ["catalina.sh", "run"]