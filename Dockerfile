# resticprofile official image already includes restic, rclone and crond
FROM creativeprojects/resticprofile:latest

# Switch to root to install additional packages
USER root

# Add postgresql-client for pg_dump
RUN apk add --no-cache postgresql-client

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
