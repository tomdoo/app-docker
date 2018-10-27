#!/bin/bash

setfacl -dR -m u:www-data:rwX -m u:root:rwX /var/www/app/storage/ \
&& setfacl -R -m u:www-data:rwX -m u:root:rwX /var/www/app/storage

echo Permissions fixed