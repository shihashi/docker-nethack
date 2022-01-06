# docker-nethack
Dockerfile for Nethack

## How to play the game

```
$ git clone https://github.com/shihashi/docker-nethack
$ cd docker-nethack
$ ./nethack
```
Then log files and save files are created at `~/nethackdir`.
The game configuration file is `~/.nethackrc`.

## How to cheat

It is NOT RECOMMENDED.

### Create monster

Apply the patch and build.
```
$ git clone https://github.com/shihashi/docker-nethack
$ cd docker-nethack/docker
$ ln -sf ../patches/monster.patch NetHack.patch
$ docker build -t nethack-monster .
```
Then launch `nethack` with the newly build image.
```
$ cd ..
$ ./nethack --image nethack-monster
```

## Reference
- [Docker Hub shihashi/nethack](https://hub.docker.com/repository/docker/shihashi/nethack)
