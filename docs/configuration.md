# Configuration

Document every environment variable, secret, and deployment-specific setting used by the generated service.

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `ENV` | No | `local` | Runtime environment name. |
| `BUILD_VERSION` | No | `local-build` | Build or release identifier. |
| `LOG_LEVEL` | No | `info` | Logging verbosity. |
| `LOG_PRETTY` | No | `on` | Local-friendly logging flag. |

Do not commit secrets. Reference the approved secret source for each sensitive value.
