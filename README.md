# Industrial Robots and Systems Simulation World

This repo support multiple versions of ROS2. Select the branch matching the ROS2 version.

| Branch | ROS2 Version |
| --- | --- |
| `main` | Jazzy Jalisco |
| `humble` | Humble Hawksbill |

## Install Docker

Follow the official instructions [here](https://docs.docker.com/engine/install/)

## Clone the repo

On the terminal run the following command to clone the repo

```sh
git clone https://github.com/CollaborativeRoboticsLab/industrial-robots-and-systems-world.git
```

## Start the workspace

Enter the folder

```bash
cd industrial-robots-and-systems-world
```

Pull the latest docker containers
```bash
docker compose pull
```

Allow permission for UI interfaces from docker containers
```bash
xhost +local:root
```

Start the docker containers
```bash
docker compose up
```

If the host machine contains a nvidia GPU, you can also start the docker containers with GPU support using the following command

```bash
docker compose -f compose-nvidia.yaml up
``` 

## Start the editor and runtime only

Enter the folder
```bash
cd industrial-robots-and-systems-world
```

Pull the latest docker containers
```bash
docker compose -f compose-plc.yaml pull
```

Allow permission for UI interfaces from docker containers
```bash
xhost +local:root
```

Start the docker containers
```bash
docker compose -f compose-plc.yaml up
```

## Accessing the st files created by editor

Make sure to save the files created using the editor into `editor_shared_folder`

Then the files will be available in the `industrial-robots-and-systems-world/openplc_data` folder.

Access them from there


## Stop the workspace

Stop the docker containers

```bash
docker compose stop
docker compose -f compose-editor.yaml stop
```

Remove docker containers

```bash
docker compose down
docker compose -f compose-editor.yaml down
```

## Changes

- Removed `omron_moma` folder and replaced with the Docker image from now complete [CollaborativeRoboticsLab/omron_moma](https://github.com/CollaborativeRoboticsLab/omron_moma.git)