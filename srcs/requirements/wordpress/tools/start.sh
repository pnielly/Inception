#!/bin/bash

#exec replaces the current process (the entrypoint script of your Dockerfile) with the one you call at the end of your entrypoint script (this script). This is necessary for correct handling of signals (see PID 1 issue with Dockerfile) 
exec php-fpm7.3 -F
