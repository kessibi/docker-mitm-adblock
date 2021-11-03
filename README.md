# docker-mitm-adblock

This *very* small project was initiated because I wanted to deploy
[mitm-adblock](https://github.com/epitron/mitm-adblock) on my personal server
without installing python or other packages.

Either launch it with `docker run -p 8118:8118 odclive/docker-mitm-adblock` or
use the docker-compose file.

This package will run `sh go -d` inside of it, dumping logs.

