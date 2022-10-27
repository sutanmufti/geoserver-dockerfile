FROM ubuntu

RUN apt update
RUN apt install -y openjdk-11-jre-headless
RUN apt install -y default-jre
RUN java --version

RUN apt-get update
RUN apt-get install -y tomcat9 tomcat9-admin
COPY tomcat-users.xml /etc/tomcat9

RUN apt install -y nano
RUN apt install -y wget
RUN apt install -y unzip

RUN systemctl enable tomcat9
RUN wget https://build.geoserver.org/geoserver/2.20.x/geoserver-2.20.x-latest-bin.zip
RUN mkdir /usr/share/geoserver
RUN mv geoserver-2.20.x-latest-bin.zip /usr/share/geoserver

WORKDIR /usr/share/geoserver
RUN unzip geoserver-2.20.x-latest-bin.zip
RUN rm geoserver-2.20.x-latest-bin.zip

RUN echo "export GEOSERVER_HOME=/usr/share/geoserver" >> ~/.profile
RUN . ~/.profile

WORKDIR /usr/share/geoserver/bin

RUN apt-get install -y tomcat9-docs tomcat9-examples 

CMD ["bash"]
ENTRYPOINT ["sh", "startup.sh"]
