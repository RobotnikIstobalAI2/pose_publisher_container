#!/bin/bash
#
# Description:   Docker stack deployer
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
cfg_files=(\
 general.config \
 pose.config \
)


function create_compose_file() {
  trim_file="/tmp/trimmed"
  for file in "${cfg_files[@]}"
  do
    sed 's/#.*$//;/^$/d' "${file}" >"${trim_file}"
    while read -r line; do
      eval "export ${line}"
    done < "${trim_file}"
  done
  envsubst < "${STACK_FILE}" | tee "${STACKED_FILE}"
  cp "${STACKED_FILE}" docker-compose.yaml
  return 0
}

function deploy() {
  if ! docker swarm ca -q &>/dev/null
  then
    docker compose up -d
    return $?
  fi
  if docker stack ps "${STACK_NAME}" --quiet &>/dev/null
  then
    docker stack rm "${STACK_NAME}"
  fi
  docker stack deploy -c "${STACKED_FILE}" "${STACK_NAME}" --with-registry-auth
  return $?
}

function deploy_main() {
  if ! create_compose_file
  then
    return 1
  fi
  if ! deploy
  then
    return 1
  fi
  return 0
}

deploy_main "${@}"
exit $?