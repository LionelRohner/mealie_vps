# Mealie
* https://github.com/mealie-recipes/mealie

## Mealie Update
* https://docs.mealie.io/documentation/getting-started/updating/#docker

## Mealie Backups
Add this to the crontab:
```shell
0 2 * * * /path/to/mealie_vps/backup_mealie.sh
```

# Swag
* https://github.com/linuxserver/docker-swag

# Docker clean up
Add this to the crontab:
0 3 * * 1,5 /usr/bin/docker system prune -af
