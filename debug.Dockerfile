FROM debian:bookworm

RUN set -ex; \
    adduser --uid 1000 --disabled-password --gecos '' app; \
    rm /etc/dpkg/dpkg.cfg.d/docker-*; \
    rm /etc/apt/apt.conf.d/docker-*; \
    echo 'APT::AutoRemove::SuggestsImportant "false";' >/etc/apt/apt.conf.d/99nosuggests; \
    apt-get update; \
    apt-get install -y bash-completion ca-certificates curl git gnupg htop less locales-all man-db openssh-server psmisc python3 rsync screen sudo tini tmux vim wget; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    echo '%sudo ALL=(ALL:ALL) NOPASSWD:ALL' >/etc/sudoers.d/00-nopasswd; \
    chmod 440 /etc/sudoers.d/00-nopasswd; \
    adduser app sudo; \
    runuser -l app -c 'curl https://0x01.me/dotfiles/setup.sh | bash'

USER app
WORKDIR /home/app
ENV HOME=/home/app
ENV LOGNAME=app
ENV PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
ENV PWD=/home/app
ENV SHELL=/bin/bash
ENV TERM=xterm-256color
ENV USER=app

ENV PATH=$HOME/.local/bin:$PATH
ENV EDITOR=vim
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en:C:zh_CN:zh
ENV LC_ADDRESS=zh_CN.UTF-8
ENV LC_COLLATE=zh_CN.UTF-8
ENV LC_CTYPE=zh_CN.UTF-8
ENV LC_IDENTIFICATION=zh_CN.UTF-8
ENV LC_MONETARY=zh_CN.UTF-8
ENV LC_MESSAGES=en_US.UTF-8
ENV LC_MEASUREMENT=zh_CN.UTF-8
ENV LC_NAME=zh_CN.UTF-8
ENV LC_NUMERIC=zh_CN.UTF-8
ENV LC_PAPER=zh_CN.UTF-8
ENV LC_TELEPHONE=zh_CN.UTF-8
ENV LC_TIME=en_DK.UTF-8
ENV TZ=Asia/Shanghai

SHELL ["tini", "-g", "--", "bash", "-c", "--"]
ENTRYPOINT ["tini", "-g", "--"]
CMD ["bash"]
