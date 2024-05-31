# Pose publisher Container
Pose publisher container on `ROS 2` topic.

## 1. Installation

Before using the Pose Publisher with Docker Container it is necessary to download the repository.

```bash
git clone git@github.com:RobotnikIstobalAI2/pose_publisher_container.git
```

**NOTE:** please note that all changes made in the Pose publisher container repository will not be updated in your local repository. To make sure that your cloned repository is updated use the following commands:

```bash
cd pose_publisher_container
git checkout humble-devel
git pull
cd ..
```

## 2. Build image

If you have not yet built the Pose publisher container image or want to make sure that all changes in the files are updated in the image, you have to build the appropriate Pose publisher container image.

You can build the image without launching the docker by using the following commands:

```bash
cd pose_publisher_container
git checkout humble-devel
cd container/builder
docker compose build
cd ../../..
```

**NOTE:** instead of using the command `docker compose build` you can run the command `docker compose build --no-cache` to build (or rebuild) the image without using the cache data.

## 3. Usage

To run the Pose publisher container, follow these steps:

```bash
cd pose_publisher_container
git checkout humble-devel
cd container
docker compose up -d
```

## 4. Docker Environment Variables Configuration

A new Docker structured approach has been implemented to prevent redundancy of environment variables within the Docker Compose files. This is achieved through the utilization of features such as include and merge to consolidate various files within the same YAML.

All the environment variables used in the YAML files are located inside the `container/environment` directory, which is further divided into two subdirectories:
- `compose`: This directory includes all the files with the environment variables needed for the YAMLs of the Docker Compose files.
- `pose`: This directory includes all the files with the environment variables needed for running the pose_publisher node.

The following files and environment variables are contained within `container/environment`:

### 4.1 COMPOSE environment files

#### - Builder configuration ([builder-config.env](./container/environment/compose/builder-config.env))

| Environment          | Default Value            | Meaning                                                       |
| -------------------- | ------------------------ | ------------------------------------------------------------- |
| `IMAGE_BASE_VERSION` | `0.5.0`                  | Image base version for building the container                 |
| `IMAGE_NAME`         | `pose-publisher`         | Image name for building the container                         |
| `REGISTRY_PROJECT`   | `robotnik`               | Registry proyect for building the container                   |
| `BUILDER_TYPE`       | `local`                  | Override or not git simulation code with local changes        |
| `ROS_MIRROR`         | `ros.mirror.robotnik.ws` | ROS apt mirror to use in order to increase the download speed |

**NOTE:** the environment `BUILDER_TYPE` could have the following values:

| Value   | Meaning                                                     |
| ------- | ----------------------------------------------------------- |
| `base`  | use the simulation repository obtained in git from vcs file |
| `local` | override simulation with local changes                      |

#### - Registry base ([registry-docker-hub.env](./container/environment/compose/registry-docker-hub.env) or [registry-robotnik.env](./container/environment/compose/registry-robotnik.env))

`REGISTRY_BASE` is the variable to your private registry, which allows to download the images (if they are present on this registry) without the need of building them locally. By default is blank, which means that it is disabled.

- [registry-docker-hub.env](./container/environment/compose/registry-docker-hub.env): This file utilizes the Docker Hub registry, thereby disabling the private registry (hence the default blank value). It serves as the default configuration in the Docker Compose files.

| Environment     | Default Value | Meaning            |
| --------------- | ------------- | ------------------ |
| `REGISTRY_BASE` | `""`          | Registry base name |

- [registry-robotnik.env](./container/environment/compose/registry-robotnik.env): This file uses the Robotnik private registry.

| Environment     | Default Value             | Meaning            |
| --------------- | ------------------------- | ------------------ |
| `REGISTRY_BASE` | `"registry.robotnik.ws/"` | Registry base name |

**NOTE:** If you employ the `REGISTRY_BASE` variable to your private registry, ensure that you add a final `/` in order to work, for example, `registry.robotnik.ws/`.

#### - Builder version ([version.env](./container/environment/compose/version.env))

| Environment         | Default Value | Meaning                            |
| ------------------- | ------------- | ---------------------------------- |
| `DOCKER_ROS_DISTRO` | `humble`      | ROS distribution of the container  |
| `VERSION`           | `devel`       | Repository version (branch or tag) |


### 4.2 POSE environment files

#### - Pose publisher configuration ([republisher.env](./container/environment/pose/republisher.env))

| Environment                        | Default Value         | Meaning                                                           |
| ---------------------------------- | --------------------- | ----------------------------------------------------------------- |
| `NODE_NAME`                        | `node_pose_publisher` | Name of the pose publisher node                                   |
| `POSE_PUBLISHER_FREQUENCY`         | `50.0`                | Frequency of publication                                          |
| `MAP_FRAME`                        | `map`                 | Robot map frame                                                   |
| `POSE_PUBLISHER_BASE_FRAME_SUFFIX` | `base_link`           | Robot base frame suffix                                           |
| `POSE_PUBLISHER_TOPIC_REPUB`       | `pose`                | Topic name where the node_pose_publisher publishes the robot pose |

#### - ROS configuration ([ros-params.env](./container/environment/pose/ros-params.env))

| Environment     | Default Value  | Meaning        |
| --------------- | -------------- | -------------- |
| `ROS_DOMAIN_ID` | `35`           | ROS2 domain ID |
| `ROBOT_ID`      | `robot`        | Robot ID       |


## 5. Additional information

### Verify the environment variables used by the Docker

To check all the environment variables employed by Docker and their corresponding values, execute the following command in a terminal within the same directory as the `compose.yaml` file:

```bash
docker compose config
```

### Finalize the Docker Compose

To stop the Docker Compose files use in a terminal in the same folder as the `compose.yaml` the following command:

```bash
docker compose down
```

### Enter on the container

If you want to enter on the container, first open another terminal and then you have 2 options:

1. Use the `docker` command with the following structure `docker exec -it container-<container-name> bash`. For example:
   
   ```bash
   docker exec -it container-pose-publisher-1 bash
   ```
   
   **Note**: Use the double tab key (`[TAB][TAB]`) if you need help to auto-complete the name of the container.

2. Use the `docker compose` command with the following structure `docker compose exec <container-name> bash`, for example:
   
   ```bash
   docker compose exec pose-publisher bash
   ```

  **Note**: Use the double tab key (`[TAB][TAB]`) if you need help to auto-complete the name of the container.

**NOTE:** in both cases, to exit from the container run in the terminal the following command:

```bash
exit
```
