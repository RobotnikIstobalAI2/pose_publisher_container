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

# Global ARGs
ARG base_image="robotnik/ros"
ARG ros_distro="noetic"
ARG image_base_version="use-args"
ARG version="use-args"
# With no local copy or the repos
# base: use the git from vcs
# local: use the ones from the local repo
# ARG builder_type=base
ARG builder_type="use-args"

FROM  ${base_image}:${ros_distro}-base-${image_base_version} as base

LABEL maintainer="Guillem Gari <ggari@robotnik.es>" \
      org.opencontainers.image.title="pose-publisher" \
      org.opencontainers.image.version="${version}" \
      org.opencontainers.image.description="Pose Publisher" \
      org.opencontainers.image.source="https://github.com/RobotnikIstobalAI2/pose_publisher_container" \
      org.opencontainers.image.vendor="Robotnik Automation S.L." \
      org.opencontainers.image.licenses="BSD-3-Clause" \
      org.opencontainers.image.authors="Guillem Gari <ggari@robotnik.es>"

FROM ${base_image}:${ros_distro}-builder-${image_base_version} as builder

USER root

ENV DEBIAN_FRONTEND=noninteractive
ARG ros_mirror="user-args"

RUN --mount=type=bind,\
source=./requirements/builder.txt,\
target=/tmp/requirements.txt \
    true \
    && if \
        timeout 2 curl -IsS http://${ros_mirror} &>/dev/null; \
        then \
        sed -i \
            "s#packages.ros.org#${ros_mirror}#" \
            /etc/apt/sources.list.d/ros-latest.list ;\
        fi \
    && apt-fast update \
    && apt-fast install -q -y \
        --no-install-recommends \
        $(eval "echo $(cat /tmp/requirements.txt | xargs)") \
    && apt-get clean -q -y \
    && apt-get autoremove -q -y \
    && rm -rf /var/lib/apt/lists/* \
    && true

USER $USER_NAME

RUN --mount=type=bind,\
source=./repos/common.repo.yaml,\
target=/tmp/common.repo.yaml,ro \
    vcs import \
        --input /tmp/common.repo.yaml  \
        --shallow

RUN generate_debs.sh

FROM base

USER root

ENV DEBIAN_FRONTEND=noninteractive
ARG ros_mirror="user-args"

RUN --mount=type=bind,\
source=./requirements/pose-publisher.txt,\
target=/tmp/requirements.txt\
    true \
    && if \
        timeout 2 curl -IsS http://${ros_mirror} &>/dev/null; \
        then \
        sed -i \
            "s#packages.ros.org#${ros_mirror}#" \
            /etc/apt/sources.list.d/ros-latest.list ;\
        fi \
    && apt-fast update \
    && apt-fast install -q -y \
        --no-install-recommends \
        $(eval "echo $(cat /tmp/requirements.txt | xargs)") \
    && sed -i "s#${ros_mirror}#packages.ros.org#" /etc/apt/sources.list.d/ros-latest.list \
    && apt-get clean -q -y \
    && apt-get autoremove -q -y \
    && rm -rf /var/lib/apt/lists/* \
    && true

RUN --mount=type=bind,\
from=builder,\
source=${USER_WORKSPACE}/debs,\
target=/tmp/debs \
    apt update && \
    apt-fast install -y --no-install-recommends \
        /tmp/debs/*.deb \
    && rm -rf /var/lib/apt/lists/*

USER $USER_NAME

RUN mkdir $USER_HOME/data
VOLUME $USER_HOME/data

# Set environment variables
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
ENV NODE_NAME "node_pose_publisher"
ENV HEALTHCHECK_NODES "/\${ROBOT_ID}/\${NODE_NAME}"

ENV POSE_PUBLISHER_FREQUENCY "50.0"
ENV MAP_FRAME "map"
ENV POSE_PUBLISHER_BASE_FRAME_SUFFIX "base_link"
ENV POSE_PUBLISHER_TOPIC_REPUB "pose"
