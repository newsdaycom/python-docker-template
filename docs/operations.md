# Operations

Document how to run, observe, deploy, roll back, and troubleshoot the generated service.

## Health And Logs

Add health-check endpoints, expected log fields, dashboards, alerts, and common failure signatures once the service has real runtime behavior.

## Deployment

Document image repository names, release tags, environment-specific settings, and rollback steps.

## Multi-architecture build contract

The default publication path builds AMD64 and ARM64 together. Stage builds require a clean checkout matching origin/stage, with feature branches based on the canonical release baseline. Use unique build tags and deploy the verified index digest; local OCI/load checks are explicitly separate from publication. See [multi-architecture guide](multiarch.md) for inputs, stage promotion, failure handling and contract tests.
