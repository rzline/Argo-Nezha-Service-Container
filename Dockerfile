FROM debian

WORKDIR /dashboard

RUN apt-get update &&\
    apt-get -y install openssh-server wget curl iproute2 vim git cron unzip supervisor nginx sqlite3
RUN wget -p /opt/alist https://github.com/xhofe/alist/releases/latest/download/alist-linux-amd64.tar.gz &&\
    tar -zxvf /opt/alist/alist-linux-amd64.tar.gz &&\
    chmod +x /opt/alist/alist-linux-amd64.tar.gz &&\
    rm /opt/alist/alist-linux-amd64.tar.gz
RUN git config --global core.bigFileThreshold 1k &&\
    git config --global core.compression 0 &&\
    git config --global advice.detachedHead false &&\
    git config --global pack.threads 1 &&\
    git config --global pack.windowMemory 50m &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    echo "#!/usr/bin/env bash\n\n\
bash <(wget -qO- https://raw.githubusercontent.com/rzline/Argo-Nezha-Service-Container/main/init.sh)" > entrypoint.sh &&\
    chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
