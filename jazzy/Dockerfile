FROM nvidia/cuda:12.6.1-base-ubuntu24.04

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics


# time zone setup
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    locales software-properties-common tzdata \
    python3-pip &&\
    locale-gen ja_JP ja_JP.UTF-8 && update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 &&\
    add-apt-repository universe


# ROS jazzy and dependencies install
RUN apt-get update && apt-get install -y curl &&\
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg &&\
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null &&\
    apt-get update && apt-get install -y ros-jazzy-ros-base \
    python3-colcon-common-extensions &&\
    pip install --break-system-packages setuptools==58.2.0  &&\
    rm -rf /var/lib/apt/lists/* 


RUN echo ". /opt/ros/jazzy/setup.bash" >> /root/.bashrc
RUN echo "export PS1='\[\033[47;30m\]\$ROS_DISTRO\[\033[0m\]:\[\033[32m\]\u:\[\033[36m\]\w \[\033[37m\]\$ '" >> /root/.bashrc

CMD ["/bin/bash"]
