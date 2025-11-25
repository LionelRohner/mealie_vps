# Mealie

* [Mealie GitHub Repository](https://github.com/mealie-recipes/mealie)
* [Mealie Docs](https://docs.mealie.io/documentation/getting-started/introduction/)

## Overview
Mealie is a neat, self-hosted recipe manager that helps you organize recipes and share them with friends and family.

## Updates
To keep your Mealie instance up-to-date, follow the official update instructions:

* [Mealie Update Documentation](https://docs.mealie.io/documentation/getting-started/updating/#docker)

## Backups
To automate backups of your Mealie instance, add the following line to your crontab:

```shell
0 2 * * * /path/to/mealie_vps/backup_mealie.sh
```

Or at any other time (see [Crontab Guru](https://crontab.guru/#0_3_*_*)).

## SWAG Configuration
For secure hosting of your Mealie instance, configure SWAG (Secure Web Application Gateway):

* [SWAG GitHub Repository](https://github.com/linuxserver/docker-swag)

# Docker Cleanup
To clean up unused Docker images and containers, schedule a cron job:

```shell
0 3 * * 1,5 /usr/bin/docker system prune -af
```
Or at any other time.
