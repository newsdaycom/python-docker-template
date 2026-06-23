# Development

Use this file to document local development workflows for the generated service.

## Local Startup

```bash
cp .env.example .env
docker network create special-projects 2>/dev/null || true
ENV=local ./rebuild
```

## Dependency Changes

Update `requirements.txt`, rebuild the image, and verify the service imports and starts successfully.

```bash
ENV=local docker compose build
python3 -m compileall index.py
```
