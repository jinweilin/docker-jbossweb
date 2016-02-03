FROM jinweilin/java:1.8.0_72

ENV CATALINA_HOME /usr/local/jboss-web
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
RUN mkdir -p "/opt/war"
RUN mkdir -p "/home/art"
WORKDIR $CATALINA_HOME

RUN apt-get update
RUN apt-get install -y curl

ENV JBOSSWEB_TGZ_URL http://downloads.jboss.org/jbossweb/2.1.9.GA/jboss-web-2.1.9.GA.tar.gz

RUN set -x \
	&& curl -f "$JBOSSWEB_TGZ_URL" -o jboss-web.tar.gz \
	&& tar -xvf jboss-web.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm jboss-web.tar.gz*

ADD server.xml $CATALINE_HOME/conf/server.xml
ADD tomcat-users.xml $CATALINE_HOME/conf/tomcat-users.xml
VOLUME ["/usr/local/jboss-web/logs","/opt/war","/home/art"]

#RUN ["rm", "-fr", "$CATALINE_HOME/webapps/ROOT"]
#RUN ["rm", "-fr", "$CATALINE_HOME/webapps/docs"]

EXPOSE 8080
EXPOSE 8009

CMD ["catalina.sh", "run"]