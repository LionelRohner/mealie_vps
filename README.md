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

## SWAG Configuration
For secure hosting of your Mealie instance, configure SWAG (Secure Web Application Gateway):

* [SWAG GitHub Repository](https://github.com/linuxserver/docker-swag)

### Diagnostics

* Monitor access logs with the following command:
```shell
docker exec -it swag tail -f /config/log/nginx/access.log
```
  * **Failed logins (401/403)**: Look for entries like `"POST /api/auth/token HTTP/2.0" 401 ...`
  * **Successful logins (200)**: Look for entries like `"POST /api/auth/token HTTP/2.0" 200 ...`

## Fail2Ban Configuration

* Add your local IP to `ignoreip` in `/etc/config/swag/fail2ban/fail.local`.

### Diagnostics

* Check Fail2Ban logs with the following command:
```shell
docker exec -it swag tail -f /config/log/fail2ban/fail2ban.log
```
* Check banned IPs with the following command:
```{shell}
docker exec -it swag fail2ban-client status nginx-unauthorized
```

# Docker Cleanup
To clean up unused Docker images and containers, schedule a cron job:

```shell
0 3 * * 1,5 /usr/bin/docker system prune -af
```
Or at any other time.
