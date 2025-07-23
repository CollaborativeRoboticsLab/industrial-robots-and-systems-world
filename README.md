# Industrial Robots and Systems Simulation World

## Install Docker

Follow the official instructions [here](https://docs.docker.com/engine/install/)

## Clone the repo

On the terminal run the following command to clone the repo

```sh
git clone https://github.com/CollaborativeRoboticsLab/industrial-robots-and-systems-world.git
```

## Use image available online

```bash
docker compose pull
xhost +local:root
docker compose up
```

## Accessing the st files created by editor

Make sure to save the files created using the editor into `editor_shared_folder`

Then the files will be available in the `industrial-robots-and-systems-world/openplc_data` folder.

Access them from there