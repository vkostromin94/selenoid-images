#!/bin/bash

set -e

docker run -d \
-v /var/run/docker.sock:/var/run/docker.sock \
-v "$(pwd)/config/":/etc/selenoid/:ro \
-p 4444:4444 \
--name selenoid \
aerokube/selenoid:latest-release \
-service-startup-timeout 10m -session-attempt-timeout 10m

docker run -d --name selenoid-ui \
-p 8080:8080 \
--link=selenoid \
aerokube/selenoid-ui:latest-release --selenoid-uri http://selenoid:4444
