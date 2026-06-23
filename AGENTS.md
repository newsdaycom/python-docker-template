# AGENTS.md

This repository is the starter template for Newsday Docker-based Python projects. Treat every change as something that may be copied into many future services.

## Core Expectations

- Keep the template generic, production-ready, and easy to rename for a new service.
- Prefer clear conventions over clever shortcuts. A new project should be understandable within a few minutes.
- Keep Docker, local development, documentation, tests, and runtime behavior in sync.
- Do not introduce service-specific business logic, secrets, private credentials, or environment-specific values into the template.
- Preserve unrelated user changes in the working tree.

## When Creating A Real Project From This Template

When this template is copied or renamed for a real service, replace template placeholders immediately. Do not leave generic names, example commands, or unused starter files in place.

Revise at minimum:

- Repository name, service name, Docker image name, Compose service name, container name, and hostname.
- README title, project purpose, ownership, support path, quick start commands, local URLs, deployment notes, and troubleshooting guidance.
- `docs/` files so they describe the real architecture, configuration, development workflow, operations model, testing strategy, and external contracts.
- `docker-compose.yaml` network, volumes, ports, service dependencies, environment variables, health checks, and logging assumptions.
- `Dockerfile` runtime dependencies, system packages, startup command, exposed ports, user permissions, and build arguments.
- `build-image`, `rebuild`, and `start-service` so script names, image repositories, required environment variables, and runtime commands match the real service.
- `.env.example` so it lists every required local variable with safe example values.
- `requirements.txt` so it contains only real dependencies with deliberate version constraints.
- `index.py` and any starter code so the module names, entry points, docstrings, and behavior match the real service.
- `docs/testing.md` and the test tree so unit, integration, and regression commands reflect the real validation workflow.
- License, ownership, and security notes if the generated repository uses a different policy than the template.

Remove at minimum:

- Placeholder text such as `python-docker-template`, `example-service`, `newsday/example-service`, and `local-build` where those values are no longer accurate.
- Unused sample code, unused environment variables, unused docs sections, and inherited template comments.
- Any local-only assumptions that do not apply to the generated service.

Before the first handoff of a generated project, run the documented quick start, Docker build, startup path, and baseline tests. Update README and `docs/` with the exact commands that passed.

## Documentation Standard

Every project created from this template must maintain both:

- A high-level `README.md` for repository entry points, setup, usage, and operational basics.
- A `docs/` directory for deeper technical documentation that does not belong in the README.

### README Requirements

The README should follow common GitHub conventions and stay useful to a new engineer, an operator, and a reviewer. At minimum, include:

- Project name and one-paragraph purpose.
- Runtime requirements, including Python version, Docker, Docker Compose, and any external services.
- Quick start commands for local development.
- Configuration reference for required and optional environment variables.
- Build, run, rebuild, test, lint, and formatting commands.
- Expected local URLs, ports, health checks, or CLI entry points.
- Deployment notes, including image naming, tags, and environment assumptions.
- Repository structure with short descriptions of important files and folders.
- Testing strategy and how to run focused tests.
- Troubleshooting notes for common Docker, dependency, or configuration failures.
- Ownership, support path, and links to any project-specific runbooks.

Keep README examples copy-pastable. When behavior changes, update the README in the same change.

### `docs/` Requirements

Use `docs/` for durable project knowledge that would make the README too long. Recommended files include:

- `docs/architecture.md` for service boundaries, data flow, dependencies, and runtime diagrams.
- `docs/configuration.md` for environment variables, secrets, and deployment-specific settings.
- `docs/development.md` for local workflows, dependency management, debugging, and common commands.
- `docs/operations.md` for health checks, logging, monitoring, rollback, and incident notes.
- `docs/testing.md` for unit, integration, fixture, and regression testing guidance.
- `docs/api.md` when the service exposes HTTP, queue, file, or data contracts.

Update docs whenever code changes alter behavior, commands, dependencies, configuration, deployment, or operational expectations.

## Python Code Style

All Python code must be authored with detailed docstring-style documentation.

- Add a module docstring to every Python file explaining the file's purpose and main responsibilities.
- Add a docstring to every public class, function, method, and CLI entry point.
- Use Google-style docstrings unless a generated project explicitly adopts another single style.
- Include `Args`, `Returns`, `Raises`, and side effects when relevant.
- Explain external I/O clearly: network calls, filesystem access, database reads/writes, subprocesses, queues, and environment variables.
- Prefer type hints for function signatures and dataclasses or typed structures for meaningful data shapes.
- Keep inline comments reserved for non-obvious decisions, edge cases, or operational context. Do not use comments that simply repeat the code.

Example:

```python
def load_settings(env_file: str | None = None) -> Settings:
    """Load runtime settings from the environment and an optional env file.

    Args:
        env_file: Optional path to a dotenv-style file used for local development.

    Returns:
        A validated Settings object used by the application at startup.

    Raises:
        SettingsError: If required configuration is missing or malformed.

    Side Effects:
        Reads process environment variables and may read a local file.
    """
```

## Commenting Standard For All Files

All project files should be as commented as practical using the native commenting syntax for that file type. Comments should be docstring-compatible: structured, durable, and useful to a future maintainer rather than casual notes.

- Add a top-of-file purpose block to source files, scripts, Docker files, Compose files, config examples, and templates.
- For languages that support docstrings, use real docstrings for modules, classes, functions, methods, and CLI entry points.
- For languages without docstrings, use structured comments that mirror docstring sections such as `Purpose`, `Usage`, `Environment`, `Inputs`, `Outputs`, `Side Effects`, and `Operational Notes`.
- Comment environment variables, ports, volumes, build arguments, secrets references, external services, filesystem paths, and non-obvious defaults.
- Keep comments accurate when behavior changes. A stale comment is a bug in the template.
- Prefer comments that explain intent, constraints, safety, and operational behavior. Avoid comments that merely restate syntax.
- Remove inherited template comments that no longer apply when creating a real project.

## Testing And Quality Gates

- Build tests as you work. Do not postpone test design until the end of an implementation unless the user explicitly requests discovery-only work.
- Add or update tests for every behavioral change, bug fix, parser rule, external contract, Docker startup path, and regression-prone edge case.
- Run the relevant test suite before signing off on work. If the full suite is too expensive for the current turn, run the focused tests that cover the changed behavior and clearly report what was not run.
- Keep tests runnable inside the Docker workflow or document why a host command is required.
- Prefer focused unit tests for pure Python behavior and integration tests for Docker, external services, or API contracts.
- Treat failing tests as part of the work. Diagnose and fix failures caused by the current change before handoff.
- Before handing off a change, run the narrowest meaningful validation and report exactly what passed or could not be run.
- Do not mark work complete when README/docs/tests no longer describe the current behavior.

### Regression Battery

Every generated project must maintain an ongoing regression battery as behavior matures.

- Keep regression tests in a predictable location such as `tests/regression/` or a documented project-specific equivalent.
- Add a regression test whenever fixing a bug that could recur, changing an external contract, adjusting data parsing, or touching a risky integration path.
- Document the regression battery in `docs/testing.md`, including required fixtures, environment variables, external services, and the exact command to run it.
- Keep regression fixtures small, deterministic, and safe to commit. Large or sensitive fixtures must be documented with retrieval instructions instead of checked in.
- Run the relevant regression tests before signing off on changes that touch covered behavior.
- Keep obsolete regression tests current or remove them in the same change that intentionally retires the behavior they protect.

## Docker Template Conventions

- Keep images small, reproducible, and explicit about runtime assumptions.
- Pin or constrain dependencies deliberately; avoid unbounded production dependencies in generated projects.
- Do not bake secrets into Docker images, Compose files, or scripts.
- Use environment variables for deployment-specific values and document each one.
- Keep local Compose behavior distinct from staging and production assumptions.
- Ensure startup scripts fail fast and produce useful logs.

## Shell Script Conventions

- Use `#!/usr/bin/env bash` for Bash scripts.
- Use `set -euo pipefail` for scripts unless there is a documented reason not to.
- Quote paths and variables.
- Prefer `$(...)` command substitution over backticks.
- Validate required environment variables before using them.
- Keep script usage comments accurate and update README command examples when scripts change.

## Dependency Management

- Keep `requirements.txt` understandable and documented for simple services.
- For larger generated projects, consider adding a lock or constraints workflow and document how it is maintained.
- Remove example dependencies and comments once a real project is created.
- Rebuild the image after dependency changes and verify imports at startup or in tests.

## Definition Of Done

A change is not ready until:

- Code, Docker files, scripts, README, and `docs/` agree with each other.
- Public Python interfaces have useful docstrings.
- New or changed behavior has tests, including regression coverage when the change fixes a bug or protects an established contract.
- Required environment variables and operational assumptions are documented.
- Relevant tests or validation commands have been run.
- The final handoff reports which tests and regression commands passed, failed, or could not be run.
- Template placeholders remain generic or have been intentionally replaced for the generated service.
