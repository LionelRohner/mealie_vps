# Mealie

* [Mealie GitHub Repository](https://github.com/mealie-recipes/mealie)
* [Mealie Docs](https://docs.mealie.io/documentation/getting-started/introduction/)

## Overview
Mealie is a neat, self-hosted recipe manager that helps you organize recipes and share them with friends and family.

Run this setup with Swag (or similar) as reverse proxy.

## Updates
To keep your Mealie instance up-to-date, follow the official update instructions:

* [Mealie Update Documentation](https://docs.mealie.io/documentation/getting-started/updating/#docker)

> **Check Release Notes:** [Mealie Release Notes](https://github.com/mealie-recipes/mealie/releases)

## Backups
To automate backups of your Mealie instance, add the following line to your crontab:

```shell
0 2 * * * /path/to/mealie_vps/backup_mealie.sh path/to/mealie_backup.log
```

* **Note**  The log file is created automatically by the backup script. Ensure that the specified path exists and that the crontab user has adequate permissions to write to that directory.

### Logrotate

To manage the log files for your Mealie instance, create a new logrotate configuration file under `/etc/logrotate.d/mealie-backup`. Use the following configuration:

**Note**: Adapt path and user!
```shell
path/to/mealie_backup.log {
    weekly
    missingok
    rotate 4
    compress
    delaycompress
    notifempty
    create 0640 <user> <user>
}
```

* To adapt scheduling time see [Crontab Guru](https://crontab.guru/#0_3_*_*).

# Docker Cleanup
To clean up unused Docker images and containers, schedule a cron job:

```shell
0 3 * * 1,5 /usr/bin/docker system prune -af
```
Or at any other time.
