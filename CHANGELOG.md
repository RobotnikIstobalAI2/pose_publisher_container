# Changelog

## Unreleased

### Added
- Added `container/compose` folder with compose files.
- Added `container/environment` folder with the environment variables.
- Added the following environment variables in `container/environment/compose`:
    - `IMAGE_BASE_VERSION` to modify the default image base version for building the container.
    - `BUILDER_TYPE` to override or not git code with local changes.
    - `ROS_MIRROR` is a ros apt mirror to increase the download speed.
    - `IMAGE_NAME` to change default value of image name for building the container.
    - `DOCKER_ROS_DISTRO` to specify the ROS distribution of the container.
    - `VERSION` to indicate the repository version (branch or tag).
    - `REGISTRY_PROJECT` to change default value of registry project for building the container (using a private `registry-robotnik` or public `registry-docker-hub` registry project).
    - `REGISTRY_BASE` to change default value of registry base name for downloading images without local building.
    

### Changed
- Changed map_frame name to `robot_map`.
- Updated Dockerfile.
- Updated github action in order to not use the repo variables instead use the environment files.
- Use of docker compose environment files for unified variables.
- New docker compose structure with, include, override and merge features (consult docker compose documention for futher information).
    - Compose files with content are located in `container/compose`, environment variables for the docker compose splitted and assigned to included.
    - Use yaml of anchors and links to avoid redefinition in the same file.
    - Refactor from `docker-compose.yaml` to `compose.yaml` to future compatibility with podman.
    - Environment variables are located in `container/environment`.
- Changed to robotnik public `robotnik/ros:noetic-base-0.5.0` ros images as docker image base.
- Changed to robotnik public `robotnik/ros:noetic-builder-0.5.0` ros images as package builder intermediate image.
- Use of `apt-fast` for parallel downloading for apt.
- Changed the repos name file from `repos/common.repo.yml` to `repos/common.repo.yaml`.
- Changed Dockerfile to: update repos name file, add apt-fast and modify the `HEALTHCHECK_NODES` environment variable.
- Modified readme and changelog files.

### Fixed
- Refactor from ci.yaml (continuous integration) to cd.yaml (continuous delivery).

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
