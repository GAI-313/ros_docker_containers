### Ubuntu 22.04 ROS2 HUMBLE
## 元となるイメージを選択
FROM osrf/ros:humble-desktop-full

## 作成するイメージにメタデータを追記
LABEL maintainer="Gai Nakatogawa"\
    version="0.0"

## 以降実行される RUN スクリプトの設定と定義
# bin/bash コマンドとして実行するようにする
SHELL ["/bin/bash", "-c"] 
# インタラクティブな応答は無効にする
ARG DEBIAN_FRONTEND=noninteractive

## 言語とタイムゾーンの設定
# 日本語化のパッケージえおインストール
RUN apt-get update ;\
    apt-get install -y --no-install-recommends \
    locales \
    language-pack-ja-base language-pack-ja \
    software-properties-common tzdata \
    fonts-ipafont fonts-ipaexfont fonts-takao
# システムの言語を日本語に設定、日本語入力も有効にする
RUN locale-gen ja_JP ja_JP.UTF-8 ;\
    update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 ;\
    add-apt-repository universe
# ロケーションを日本に設定し、言語を日本語に設定
ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo

## ROS やその他必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    build-essential cmake g++ \
    iproute2 gnupg gnupg1 gnupg2 \
    libcanberra-gtk* \
    python3-pip  python3-tk \
    git wget curl \
    x11-utils x11-apps terminator xterm xauth \
    terminator xterm nano vim htop \
    software-properties-common gdb valgrind sudo \
    python3-colcon-common-extensions

## jupyter notebook
RUN pip install notebook

## ユーザー設定
ARG UID
ARG GID
ARG USER_NAME
ARG GROUP_NAME
ARG PSWD
ARG WS_DIR
RUN groupadd -g $GID $GROUP_NAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USER_NAME && \
    echo $USER_NAME:$PSWD | chpasswd && \
    echo "$USER_NAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ${USER_NAME}
WORKDIR /home/${USER_NAME}

## nano
COPY ./nanorc /home/${USER_NAME}/.nanorc

## ROS ワークスペースの作成
RUN mkdir -p ros_ws/src/ros_pkgs
COPY ./ros_pkgs /home/${USER_NAME}/ros_ws/src/ros_pkgs
RUN cd ros_ws; source /opt/ros/humble/setup.bash ;colcon build

## .bashrc の設定
RUN echo "PS1='\[\033[47;30m\]HUMBLE\[\033[0m\]@\[\033[32m\]\u\[\033[0m\]:\[\033[1;33m\]\w\[\033[0m\]$ '" >> /home/${USER_NAME}/.bashrc
RUN echo "source /opt/ros/humble/setup.bash" >> /home/${USER_NAME}/.bashrc
RUN echo "source /home/${USER_NAME}/ros_ws/install/setup.bash" >> /home/${USER_NAME}/.bashrc

WORKDIR /home/${USER_NAME}/ros_ws/src
