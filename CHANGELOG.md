# Changelog

## [0.1.4-rc05] - 2024-06-04

### Added
- Added `container/compose` folder with compose files.
- Added `container/environment` folder with the environment variables.
- Added the following environment variables in `container/environment/compose`:
    - `IMAGE_BASE_VERSION` to modify the default image base version for building the container.
    - `IMAGE_NAME` to change default value of image name for building the container.
    - `REGISTRY_PROJECT` to change default value of registry project for building the container.
    - `BUILDER_TYPE` to override or not git code with local changes.
    - `ROS_MIRROR` is a ros apt mirror to increase the download speed.
    - `REGISTRY_BASE` to change default value of registry base name for downloading images without local building.
    - `DOCKER_ROS_DISTRO` to specify the ROS distribution of the container.
    - `VERSION` to indicate the repository version (branch or tag).
- Added the following environment variables in `container/environment/pose`:
    - `ROS_DOMAIN_ID` to change default value of ROS2 domain id.
    - `ROBOT_ID` to modify the default robot ID.
    - `NODE_NAME` to change default value of the node_pose_publisher name.
    - `POSE_PUBLISHER_FREQUENCY` to change default value of the publishing frequency for the node_pose_publisher.
    - `MAP_FRAME` to modify default value of the robot map frame.
    - `POSE_PUBLISHER_BASE_FRAME_SUFFIX` to change default value of robot base frame suffix.
    - `POSE_PUBLISHER_TOPIC_REPUB` to modify default value of the topic name where the node_pose_publisher publishes.


### Changed
- Modified in `container/builder/repos/common.repo.yml` the branch of the repository `pose_publisher` from `ros1` `0.1.3` to `ros2` `0.1.4-rc02`.
- Modified the files `builder.txt` and `pose-publisher.txt` of the `container/builder/requirements` folder with the ros2 dependencies.
- New docker compose structure with, include, override and merge features (consult docker compose documention for futher information).
    - Compose files with content are located in `container/compose`, environment variables for the docker compose splitted and assigned to included.
    - Use yaml of anchors and links to avoid redefinition in the same file.
    - Refactor from `docker-compose.yaml` to `compose.yaml` to future compatibility with podman.
    - Environment variables are located in `container/environment`.
- Updated `README.md` file.

### Fixed
- Refactor from ci.yaml (continuous integration) to cd.yaml (continuous delivery)

## [0.1.3] - 2023-12-05

### Added
- Added `README.md`

### Changed
- New container folder and variable structure
- Now uses version `0.1.3` of pose publisher
- Improved github actions workflows
- Changed to robotnik public `robotnik/ros:melodic-{base/builder}-a07f857-20231115` ros images as docker image base.

### Removed
- Removed container fix for pose_publisher version 0.1.2-rc01

## [0.1.2-rc01] - 2023-09-25

### Fixed
- Fixed demo compose

### Changed
- updated to package version `0.1.2-rc01`

### Removed
- Remove bringup launch file (now included on the base package)


## [0.1.1-rc01] - 2023-09-22

### Added
- deployment for docker swarm or compose in case that swarm is not available

### fixed
- Fixed version name

## [0.1.0-rc01] - 2023-09-19

### Added
- First release


## [Unreleased] 
