# python-docker-template

Starter template for Newsday Docker-based Python services.

Use this repository when creating a new Python service that should run consistently in Docker for local development, testing, and deployment. The template includes a minimal Python entry point, Docker image definition, Compose workflow, shell helpers, documentation expectations, and baseline ignore rules.

## Requirements

- Python 3.13 for host-side development.
- Docker and Docker Compose v2.
- Access to the local Docker network used by Newsday services, when running with the default Compose file.

## Quick Start

```bash
cp .env.example .env
docker network create special-projects 2>/dev/null || true
ENV=local ./rebuild
```

To run without rebuilding:

```bash
ENV=local docker compose up
```

To run the Python entry point directly on the host:

```bash
python3 index.py
```

## Configuration

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `ENV` | No | `local` | Runtime environment name. Use `local`, `stage`, or `production` unless a generated service documents additional values. |
| `BUILD_VERSION` | No | `local-build` | Build identifier surfaced to the application at runtime. Deployment tooling should set this to the image or release version. |
| `LOG_LEVEL` | No | `info` | Logging verbosity for generated services that support structured logging. |
| `LOG_PRETTY` | No | `on` | Local-friendly log formatting flag for generated services that support it. |

Add project-specific variables to this table as soon as a generated service depends on them. Never commit secrets or production credentials.

## Common Commands

```bash
# Build the local image.
ENV=local docker compose build

# Start the local service.
ENV=local docker compose up

# Rebuild, restart, and follow logs.
ENV=local ./rebuild

# Build and push a tagged deployment image.
ENV=production REPO_NAME=newsday/example-service ./build-image

# Run Python syntax checks for the starter files.
python3 -m compileall index.py
```

## Repository Structure

| Path | Purpose |
| --- | --- |
| `AGENTS.md` | Authoring rules for agents and contributors working in this template. |
| `Dockerfile` | Production-oriented Python image definition. |
| `docker-compose.yaml` | Local Compose workflow for the generated service. |
| `index.py` | Minimal documented Python entry point. |
| `requirements.txt` | Python dependency list for simple services. |
| `build-image` | Helper for building and pushing a tagged Docker image. |
| `rebuild` | Helper for rebuilding and restarting the local Compose service. |
| `start-service` | Container startup script. |
| `docs/` | Durable technical documentation for architecture, development, operations, testing, and service contracts. |

## Documentation

Keep this README accurate as the public entry point for the repository. Use `docs/` for deeper technical material:

- `docs/architecture.md`
- `docs/configuration.md`
- `docs/development.md`
- `docs/operations.md`
- `docs/testing.md`
- `docs/api.md`

When code, Docker behavior, environment variables, commands, or deployment assumptions change, update the README and the relevant file in `docs/` in the same change.

## Testing And Quality

Generated projects should add focused tests as soon as behavior is introduced. At minimum, validate:

- Python syntax and imports.
- Unit tests for pure business logic.
- Integration tests for external services, HTTP endpoints, queues, files, or databases.
- Regression tests for fixed bugs, external contracts, data parsing, and high-risk workflows.
- Docker startup behavior for runtime changes.

Recommended baseline commands for a generated service:

```bash
python3 -m compileall .
python3 -m pytest
python3 -m pytest tests/regression
ENV=local docker compose up --build
```

Document the maintained regression battery in `docs/testing.md`, including fixtures, required environment variables, external service assumptions, and exact commands.

## Deployment Notes

`build-image` builds and pushes an image tagged as `build-<branch>-<timestamp>`. Set `REPO_NAME` to the deployment repository before using it:

```bash
ENV=production REPO_NAME=newsday/example-service ./build-image
```

Deployment-specific values must come from environment variables, secrets managers, or deployment configuration. Do not bake secrets into the Docker image, Compose file, or shell scripts.

## Troubleshooting

- If Compose fails because the `special-projects` network does not exist, create it with `docker network create special-projects`.
- If dependency installation fails during image build, check `requirements.txt` pins and rebuild with `docker compose build --no-cache`.
- If the service exits immediately, run `ENV=local docker compose logs --follow` and confirm `index.py` has a real entry point for the generated service.
- If scripts fail with missing environment variables, confirm `.env` or the shell exports include the required values.

## Ownership

This template is maintained for Newsday Python Docker services. Generated repositories should replace this section with the owning team, escalation path, and project-specific support links.
