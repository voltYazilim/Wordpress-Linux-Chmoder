#!/bin/bash
#
# This script configures WordPress file permissions based on recommendations
# from http://codex.wordpress.org/Hardening_WordPress#File_permissions
#
# execute it with the following command:
# bash set-wordpress-permissions.sh /var/www/<site_folder>
#
OWNER=apache # <-- wordpress owner
GROUP=www # <-- wordpress group
ROOT=$1 # <-- wordpress root directory

# reset to safe defaults
find ${ROOT} -exec chown ${OWNER}:${GROUP} {} \;
find ${ROOT} -type d -exec chmod 755 {} \;
find ${ROOT} -type f -exec chmod 644 {} \;

# allow wordpress to manage wp-config.php (but prevent world access)
chgrp ${GROUP} ${ROOT}/wp-config.php
chmod 660 ${ROOT}/wp-config.php

# allow wordpress to manage wp-content
find ${ROOT}/wp-content -exec chgrp ${GROUP} {} \;
find ${ROOT}/wp-content -type d -exec chmod 775 {} \;
find ${ROOT}/wp-content -type f -exec chmod 664 {} \;