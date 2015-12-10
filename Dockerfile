FROM extvos/java:7
MAINTAINER "Mingcai SHEN <archsh@gmail.com>"
ENV KIBANA_VERSION 4.1.1

# download and extract 
RUN cd /opt \
	&& wget https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz \
	&& tar zxvf kibana-${KIBANA_VERSION}-linux-x64.tar.gz \
	&& groupadd -r kibana && useradd -r -g kibana kibana \
	&& ln -s /opt/kibana-${KIBANA_VERSION}-linux-x64 /opt/kibana

COPY docker-entrypoint.sh /

RUN yum install -y ca-certificates \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
	&& chmod +x /usr/local/bin/gosu \
	&& chmod +x /docker-entrypoint.sh

ENV PATH /opt/kibana/bin:$PATH

EXPOSE 5601
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]