# Pose publisher Container
Pose publisher container on topic

## Configuration

The `environment` folder, located at `container/environment`, contains all the files with the environment variables used on the docker images.

You can configure them.

### Environment variables

#### ROS Params ([ros-params.env](./container/environment/pose/ros-params.env))
| Environment  | Default Value  | Meaning  |
|------------- | -------------- | -------- |
| `ROBOT_ID`   | `robot`        | Robot id |

#### Pose Publisher Params ([republisher.env](./container/environment/pose/republisher.env))
| Environment                        | Default Value         | Meaning                                 |
| ---------------------------------- | --------------------- | --------------------------------------- |
| `NODE_NAME`                        | `node_pose_publisher` | Name of the node                        |
| `POSE_PUBLISHER_FREQUENCY`         | `50.0`                | Frequency of robot pose msg publication |
| `MAP_FRAME`                        | `robot_map`           | Map frame name                          |
| `POSE_PUBLISHER_BASE_FRAME_SUFFIX` | `base_link`           | Base frame name                         |
| `POSE_PUBLISHER_TOPIC_REPUB`       | `pose`                | Topic where the robot pose is published |

## Image build

```bash
git clone git@github.com:RobotnikIstobalAI2/pose_publisher_container.git
cd pose_publisher_container
git checkout noetic-devel
cd container/builder
docker compose build
cd ..
```

## Launch docker with robot pose publisher

```bash
docker compose up -d
```