# Industrial Robots and Systems Simulation World

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

## Start the editor

Enter the folder

```bash
cd industrial-robots-and-systems-world
```

Pull the latest docker containers
```bash
docker compose -f compose-editor.yaml pull
```

Allow permission for UI interfaces from docker containers
```bash
xhost +local:root
```

Start the docker containers
```bash
docker compose -f compose-editor.yaml up
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