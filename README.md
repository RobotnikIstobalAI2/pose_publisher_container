# Pose publisher Container
Pose publisher container on topic

## Configuration

The following environment variables are used on the docker image:

You can configure it throught the docker-compose file

```yaml
---
---
name: pose-publisher
services:
  core:
    image: pose-publisher:noetic-0.1.3-rc01
    environment:
      ROBOT_ID: "robot"
      POSE_PUBLISHER_FREQUENCY: "10"
      POSE_PUBLISHER_BASE_FRAME_SUFFIX: "base_footprint"
      POSE_PUBLISHER_TOPIC_REPUB: "pose"
      MAP_FRAME: "robot_map"
```
## Image build

```bash
git clone git@github.com:RobotnikIstobalAI2/pose_publisher_container.git
cd pose_publisher_container
git checkout noetic-devel
cd container/builder
docker compose build
cd ..
```

## Launch docker with mqtt-bridge

```bash
docker compose up
```