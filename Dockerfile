FROM tomcat

MAINTAINER Sun.Hao "sunhao.java@gmail.com"

# 删除原来的
RUN rm -rf /usr/local/tomcat/webapps/*

# 复制文件
COPY ./web /usr/local/tomcat/webapps/ROOT

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# 安装svn
CMD [ "/usr/bin/svnserve", "--daemon", "--foreground", "--root", "/var/opt/svn" ]
EXPOSE 3690
VOLUME [ "/var/opt/svn" ]
WORKDIR /var/opt/svn

RUN apt-get update && apt-get install -y subversion subversion-tools

COPY ./run.sh /opt/
RUN chmod u+x /opt/run.sh
CMD [ "/opt/run.sh" ]