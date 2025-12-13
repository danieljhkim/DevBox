# Logging Convention

- Write service logs to: logs/<service>.log
- Prefer JSON logs if possible: {ts, level, service, msg, correlationId, ...}
- Include nodeId/shardId when relevant.
