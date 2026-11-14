# Configuration

Document every environment variable, secret, and deployment-specific setting used by the generated service.

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `ENV` | No | `local` | Runtime environment name. |
| `BUILD_VERSION` | No | `local-build` | Build or release identifier. |
| `LOG_LEVEL` | No | `info` | Logging verbosity. |
| `LOG_PRETTY` | No | `on` | Local-friendly logging flag. |

Do not commit secrets. Reference the approved secret source for each sensitive value.

Build invocation requires ENV and REPO_NAME; BUILD_SOURCE_SHA optionally pins the source. BUILD_PLATFORMS defaults to linux/amd64,linux/arm64. BUILD_OUTPUT selects push/oci/load; OCI requires BUILD_OUTPUT_PATH. BUILD_TAG may supply a unique Docker tag. See multiarch.md for constraints and deployment provenance.
