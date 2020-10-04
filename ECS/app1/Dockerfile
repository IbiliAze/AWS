FROM linux

MAINTAINER Ibi Hasanli <ibili73@gmail.com>

RUN ls

RUN yum install -y httpd

RUN service httpd start

COPY ./scripts.sh /usr/local/bin

WORKDIR /usr/local/bin

RUN chmod +x scripts.sh

CMD ["scripts.sh"]

