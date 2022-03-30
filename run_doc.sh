#!/bin/bash

docker run -it --rm -p 8080:8080 -v $(pwd)/architecture:/usr/local/structurizr structurizr/lite
