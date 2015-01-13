FROM dockerfile/java

ENV GRAYLOG2_VERSION 0.92.3

RUN curl -L "http://packages.graylog2.org/releases/graylog2-web/graylog2-web-${GRAYLOG2_VERSION}.tgz" | tar -zx -C /opt/

WORKDIR /opt/graylog2-web-${GRAYLOG2_VERSION}/

RUN ln -sf /opt/graylog2-web-${GRAYLOG2_VERSION}/ /opt/graylog2-web
RUN cp /opt/graylog2-web/graylog2.conf.example /etc/graylog2.conf

COPY graylog2-web-interface.conf /opt/graylog2-web/conf/graylog2-web-interface.conf
COPY config_manifest /etc/config_manifest
COPY allowed_variables /etc/allowed_variables
COPY config_template_processor.sh /usr/bin/config_template_processor.sh

EXPOSE 12900

ENTRYPOINT ["/usr/bin/config_template_processor.sh"]

WORKDIR /opt/graylog2-web
CMD ["bin/graylog2-web-interface"]

