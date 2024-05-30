# Changelog

## [Unreleased]

### Added
- Added `environment` folder, with the environment variables.

### Changed
- Modified in `repos/common.repo.yml` the branch of the repository `pose_publisher` from `ros1` `0.1.3` to `ros2` `0.1.4-rc01`.
- Modified `requirements` with the ros2 dependencies.
- New docker compose structure with, include, override and merge features (consult docker compose documention for futher information).
    - Compose files with content are located in `container/compose`, environment variables for the docker compose splitted and assigned to included.
    - Use yaml of anchors and links to avoid redefinition in the same file.
    - Refactor from `docker-compose.yaml` to `compose.yaml` to future compatibility with podman.

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
