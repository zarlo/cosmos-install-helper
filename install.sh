#!/bin/bash
cd ./Cosmos
make build
make publish
make install
make nuget-install
