FROM centos:6
MAINTAINER rmkn
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8 && sed -i -e "s/en_US.UTF-8/ja_JP.UTF-8/" /etc/sysconfig/i18n
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime && echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
RUN yum -y update

RUN curl -o /tmp/node.sh --location https://rpm.nodesource.com/setup_4.x && sh /tmp/node.sh
COPY mongodb.repo /etc/yum.repos.d/

RUN yum -y install nodejs curl GraphicsMagick npm mongodb-org util-linux-ng
RUN npm install -g inherits

RUN curl -L https://rocket.chat/releases/latest/download -o /tmp/rocket.chat.tgz \
        && tar zxf /tmp/rocket.chat.tgz -C /usr/local \
	&& mv /usr/local/bundle /usr/local/Rocket.Chat

WORKDIR /usr/local/Rocket.Chat/programs/server
RUN npm install

ENV PORT 80
ENV ROOT_URL http://localhost/
ENV MONGO_URL mongodb://localhost:27017/rocketchat

COPY entrypoint.sh /

VOLUME /data/db
EXPOSE 80

CMD ["node", "/usr/local/Rocket.Chat/main.js"]

ENTRYPOINT ["/entrypoint.sh"]

