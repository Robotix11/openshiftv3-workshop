FROM registry.access.redhat.com/rhscl/php-70-rhel7

USER root:0

RUN yum -y install rubygem-asciidoctor

ADD images /opt/app-root/src/
ADD *.adoc /opt/app-root/src/

RUN asciidoctor /opt/app-root/src/*.adoc -D /opt/app-root/src/
RUN rm -rf /opt/app-root/src/*.adoc

RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root

USER 1001

EXPOSE 8080
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]
