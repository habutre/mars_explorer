#!/bin/bash
echo "Build docker image company/mars_explorer:0.1.0"
docker build -f Dockerfile-multi-stage -t company/mars_explorer:0.1.0 .

