#!/bin/bash

curl -s http://169.254.269.254/latest/meta-data/ #all the metadata available to query

curl -s http://169.254.169.254/latest/meta-data/instance-id #example query
