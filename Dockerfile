FROM alpine:3.10
MAINTAINER thanos_me <thanosme@totallynoob.com>

COPY ./frp_0.29.0_linux_amd64.tar.gz /tmp/frp_0.29.0_linux_amd64.tar.gz

ENV frps_version=0.29.0 \
    frps_DIR=/usr/local/bin/frps
	
RUN echo 'http://mirrors.ustc.edu.cn/alpine/v3.10/main' > /etc/apk/repositories && \
    echo 'http://mirrors.ustc.edu.cn/alpine/v3.10/community' >>/etc/apk/repositories && \
    apk add -U tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    apk add --no-cache --virtual .build-deps&& \
#   wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v0.29.0/frp_0.29.0_linux_amd64.tar.gz && \
    cd /tmp && \
    tar zxvf frp_0.29.0_linux_amd64.tar.gz && \
    mv frp_0.29.0_linux_amd64/frps /usr/local/bin/ && \
    rm -r frp_0.29.0_linux_amd64* && \
    chmod +x /usr/local/bin/frps && \
    apk del .build-deps
	
EXPOSE 80 443 7000 7500
VOLUME /data
ENTRYPOINT ["/usr/local/bin/frps", "-c", "/data/frps.ini"]

## ****************************** 参考资料 *****************************************
## 制作Docker Image: docker build -t idu/frps:0.29.0 .
## docker run -d \
## --restart=always \
## --network host \
## -v $PWD/data:/data \
## --hostname=frps \
## --name frps \
## idu/frps:0.29.0