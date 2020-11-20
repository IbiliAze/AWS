FROM centos:8

LABEL IBI HASANLI <ibili73@gmail.com>

RUN yum update -y && yum install -y httpd

RUN service httpd start && service httpd enable

COPY ./index.html /var/www/html/index.html

ADD bootstrap.sh /bootstrap.sh

RUN chmod 777 /bootstrap.sh

CMD ["/bootstrap.sh"]
