# Testing

Document the generated service's testing strategy and required validation commands.

Tests should be added as behavior is implemented. A change is not ready for handoff until the relevant tests have been run and the result is reported.

## Baseline Checks

```bash
python3 -m compileall .
python3 -m pytest
ENV=local docker compose up --build
```

## Test Layers

- Unit tests should cover pure Python behavior and edge cases.
- Integration tests should cover HTTP endpoints, queues, files, databases, external APIs, and Docker startup paths.
- Regression tests should protect previously fixed bugs, established external contracts, and high-risk parsing or data transformation behavior.

## Regression Battery

Maintain an ongoing regression battery in `tests/regression/` or document the generated service's chosen location here.

Document:

- The exact command to run the regression battery.
- Required fixtures and where they live.
- Required environment variables.
- External services, containers, or credentials needed by the tests.
- Any known runtime cost or reasons the full battery cannot run in every local handoff.

Recommended command once regression tests exist:

```bash
python3 -m pytest tests/regression
```

Update this file when tests require fixtures, external services, credentials, data snapshots, or focused regression commands.
