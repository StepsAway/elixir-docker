# Docker base images for Elixir

Elixir-docker is a set of is a set of [Docker](https://www.docker.com) images meant to serve as good bases for **Elixir**. It uses [stepsaway/baseimage-docker](https://hub.docker.com/r/stepsaway/baseimage/) as it base image and builds & installs Elixir from source.

## Images

Each major version of Elixir has its own image and the patch level changes are included in the tag.

## Tags

The tags for Elixir-docker include the patch level for the major Elixir version, followed by the version of stepsaway/baseimage-docker which Elixir-docker uses for its base image. For example, Elixir 1.5.1 on stepsaway/baseimage:1.0.2 would be: _stepsaway/baseimage-elixir15:1-2.0.1_
