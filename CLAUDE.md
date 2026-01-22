# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Automatable Launch Pad - A landing page for Automatable, specializing in AI-powered business automation solutions.

## Tech Stack

- **Backend**: Django 5.0+ with Gunicorn
- **Database**: PostgreSQL (production), SQLite (development)
- **Static Files**: WhiteNoise for serving static assets
- **Deployment**: DigitalOcean App Platform

## Development Commands

```bash
# Create virtual environment
python -m venv .venv && source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run development server
python manage.py runserver

# Run migrations
python manage.py migrate

# Collect static files
python manage.py collectstatic --noinput

# Create superuser
python manage.py createsuperuser

# Run tests
pytest
```

## Architecture

```
launchpad/
├── launchpad/          # Django project settings
│   ├── settings.py     # Configuration (uses env vars)
│   ├── urls.py         # URL routing
│   └── wsgi.py         # WSGI entry point
├── templates/          # HTML templates
├── static/             # Static assets (CSS, JS, images)
├── .do/app.yaml        # DigitalOcean App Platform config
└── manage.py           # Django CLI
```

## Deployment

App Platform auto-deploys on push to `main`. Configuration in `.do/app.yaml`.

Environment variables required:
- `DJANGO_SECRET_KEY` - Secret key (set in DO dashboard)
- `DATABASE_URL` - PostgreSQL connection string (auto-set by DO)
