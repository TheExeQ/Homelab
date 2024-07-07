# Perforce Helix Core Server (Docker)

## Build the docker image

The `helix-p4d/build.sh` script will build the docker image for you. If you don't provide a tag to the script it will tag the image as `theexeq/helix-p4d:dev`

    ./build.sh <tag>

## Usage

It is strongly recommended to use the provided example docker compose file. After you have modified it to fit your needs run the following command and you are set!

    docker compose -f docker-compose.yml up -d

## Backup

Run the following command inside the docker container or remotely from a client with super user access, the checkpoint files will be saved in `volumes/p4-home/checkpoints/`

> **_Optional Flags:_**<br>
> With -z, both the checkpoint and the journal are compressed. <br>
> With -Z, only the checkpoint is compressed. The journal is left uncompressed. <br>
> Without -z or -Z, the checkpoint and journal files are not compressed.

    p4 admin checkpoint [-z | -Z]

and then zip up the depots directory e.g.

    cd volumes/p4-home/depots/
    tar cvfz depots.tar.gz *

Copy both the `volumes/p4-home/depots/depots.tar.gz` and `volumes/p4-home/checkpoints/master.ckp.*.gz ` to a safe location

## Restore

> **_NOTE:_** restoring will override the serverid with P4NAME provided from the docker compose file. This might cause issues if the id doesn't match the backup

1. Copy your backed up checkpoint and journal files to `volumes/p4-home/depots/` with the names `latest.ckp & latest.jnl`
2. Unzip the `depots.tar.gz` into the `volumes/p4-home/depots/` directory
3. Restart docker compose.

## Credits

This repository is based of https://github.com/sourcegraph/helix-docker
