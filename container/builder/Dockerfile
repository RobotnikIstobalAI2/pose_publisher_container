# Description:   Pose publisher container
#
# Company:       Robotnik Automation S.L.
# Creation Year: 2023
# Author:        Guillem Gari <ggari@robotnik.es>
#
#
# Copyright (c) 2023, Robotnik Automation S.L.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the Robotnik Automation S.L. nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Robotnik Automation S.L.L. BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
ARG base_image="robotnik/ros"
ARG ros_distro="melodic"
ARG image_base_version="use-args"

FROM ${base_image}:${ros_distro}-builder-${image_base_version} as builder

USER root

RUN --mount=type=bind,source=./docker/requirements/builder.txt,target=/tmp/requirements.txt true \
  && apt-get update \
  && apt-get install -q -y \
  --no-install-recommends \
    $(eval "echo $(cat /tmp/requirements.txt | xargs)") \
  && apt-get clean -q -y \
  && apt-get autoremove -q -y \
  && rm -rf /var/lib/apt/lists/*

USER $USER_NAME

RUN --mount=type=bind,\
source=./docker/repos/common.repo.yml,\
target=/tmp/common.repo.yml,ro \
     vcs import \
        --input /tmp/common.repo.yml  \
        --shallow

# COPY docker/launch/pose_publisher_bringup.launch \
#   src/pose_publisher/launch

RUN  sed -i 's#DIRECTORY launch/#DIRECTORY launch#' src/pose_publisher/CMakeLists.txt

RUN generate_debs.sh

FROM  ${base_image}:${ros_distro}-base-${image_base_version} as base

LABEL maintainer="Guillem Gari <ggari@robotnik.es>" \
      org.opencontainers.image.title="pose-publisher" \
      org.opencontainers.image.version="0.1.3-rc01" \
      org.opencontainers.image.description="Open-RMF Core bringup" \
      org.opencontainers.image.source="https://github.com/RobotnikIstobalAI2/pose_publisher_container" \
      org.opencontainers.image.vendor="Robotnik Automation S.L." \
      org.opencontainers.image.licenses="BSD-3-Clause" \
      org.opencontainers.image.authors="Guillem Gari <ggari@robotnik.es>"
USER root

RUN --mount=type=bind,source=./docker/requirements/pose-publisher.txt,target=/tmp/requirements.txt true \
  && apt-get update \
  && apt-get install -q -y \
  --no-install-recommends \
    $(eval "echo $(cat /tmp/requirements.txt | xargs)") \
  && apt-get clean -q -y \
  && apt-get autoremove -q -y \
  && rm -rf /var/lib/apt/lists/*

USER root
RUN --mount=type=bind,from=builder,source=${USER_WORKSPACE}/debs,target=/tmp/debs \
    apt update && \
    apt-get install -y --no-install-recommends \
        /tmp/debs/*.deb \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash", "-c", "/usr/local/bin/ros_launcher.sh"]

USER $USER_NAME

RUN mkdir $USER_HOME/data
VOLUME $USER_HOME/data

ENV STARTUP_TYPE "launch"
# package to launch
ENV ROS_BU_PKG "pose_publisher"
# script of program to launch with all its arguments
ENV ROS_BU_LAUNCH "pose_publisher_bringup.launch"

### Required nodes to startup
#### if true check if the NODES_TO_CHECK nodes are started up before starting the program
ENV CHECK_NODES "false"
#### space separted node list with full namespace
ENV NODES_TO_CHECK "/rosout"

ENV ROBOT_ID "robot"
ENV NODE_NAME "pose_publisher"
ENV HEALTHCHECK_NODES "/${ROBOT_ID}/pose_publisher"

ENV POSE_PUBLISHER_FREQUENCY "10"
ENV POSE_PUBLISHER_BASE_FRAME_SUFFIX "base_footprint"
ENV POSE_PUBLISHER_TOPIC_REPUB "pose"
ENV MAP_FRAME "robot_map"
