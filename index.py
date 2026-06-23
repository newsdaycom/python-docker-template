"""Minimal runtime entry point for services generated from this template.

Generated projects should replace this module with the real service startup
logic while preserving the same documentation standard: module docstrings,
typed public functions, and clear docstrings for every entry point.
"""

from __future__ import annotations

import os


def main() -> None:
    """Run the starter application entry point.

    The template intentionally does very little until a generated service adds
    real behavior. Keeping this entry point explicit lets Docker startup,
    syntax checks, and documentation examples work out of the box.

    Side Effects:
        Reads the `ENV` and `BUILD_VERSION` environment variables and writes a
        startup message to standard output.
    """
    env = os.getenv("ENV", "local")
    build_version = os.getenv("BUILD_VERSION", "local-build")
    print(f"python-docker-template started env={env} build_version={build_version}")


if __name__ == "__main__":
    main()
