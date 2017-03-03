#!/bin/bash

/usr/bin/docker stop nginx
/usr/bin/docker stop nginx-gen
/usr/bin/docker stop nginx-letsencrypt
/usr/bin/docker rm nginx
/usr/bin/docker rm nginx-gen
/usr/bin/docker rm nginx-letsencrypt
