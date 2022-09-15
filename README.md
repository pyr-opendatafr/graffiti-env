[![pulls](https://img.shields.io/docker/pulls/jdinsee/graffiti-poc)](https://hub.docker.com/r/jdinsee/graffiti-poc "Number of pulls from Docker Hub")
![image](https://img.shields.io/docker/image-size/jdinsee/graffiti-poc/0.1.8)
[![dockerfile](https://img.shields.io/badge/dockerfile%20on-docker-blue.svg)](https://hub.docker.com/r/jdinsee/graffiti-poc "Dockerfile source repository")
[![base](https://img.shields.io/badge/depends%20on-rocker/shiny-blue)](https://hub.docker.com/r/rocker/shiny "Docker base image")

graffiti deployment R package
================

## Overview

*Experimental*

This package contains deployment files of [graffiti](https://github.com/pyr-opendatafr/graffiti) R package. At the moment, the docker image is hosted at Docker Hub in this [repository](https://hub.docker.com/r/jdinsee/graffiti-poc/tags).


## Use

``` r
# Commands used to deploy graffiti app over a rtudio service host by SSP Cloud
# In a terminal of rstudio:
helm dependency update graffiti-env/
helm install graffiti-env/ --generate-name
# Verify the deployment
kubectl get pods
# Get informations of a pod:
kubectl describe pod <pod_name>
kubectl --v=8 logs <pod_name>

```
## Contributing

All contributions are welcome !!

## Support

Feel free to open an issue with any question about this package using <https://github.com/pyr-opendatafr/graffiti-env/issues> Github repository.
