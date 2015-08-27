#FROM ubuntu:14.04
FROM mazzolino/armhf-ubuntu:14.04
MAINTAINER Daniel Chalef <daniel.chalef@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'

# Work-around for strange libpam-systemd post-configuration error that does only appears on armhf platforms
RUN touch /etc/init.d/systemd-logind

RUN apt-get update; apt-get upgrade -y

RUN apt-get install -y wget
RUN wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -

RUN apt-get update && apt-get install -y \
	ros-jade-ros-base python-rosdep python-rosinstall

RUN rosdep init; rosdep update

RUN echo "source /opt/ros/jade/setup.bash" >> ~/.bashrc

