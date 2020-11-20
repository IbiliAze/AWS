#!/bin/sh

set -e
echo $(printenv) >> /usr/local/apache2/htdocs/index.html


httpd-foreground
