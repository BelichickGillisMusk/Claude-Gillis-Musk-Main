# Gillis Main Operating Manual

This repository is the home base for Bryan's operating system: daily routines,
project notes, repeatable scripts, and the working plan for Samantha.

It is intentionally simple. There is no app server, package manager, or build
step in this repo. The repo is a clean handbook plus a few Bash scripts that
help keep the day organized.

## What belongs here

- The daily and weekly workflow Bryan wants agents to follow.
- Plain-English instructions that still make sense to a beginner.
- Templates for logs, projects, and meetings.
- Roadmaps for bigger projects that should live in their own repositories.
- Small shell scripts that automate routine check-ins.

## What does not belong here

- The production Samantha app code.
- Secrets, API keys, tokens, or credentials.
- Large customer files, private uploads, or generated project folders.
- Half-built experiments that need their own repo.

For Samantha app work, start with
[`docs/samantha-app-roadmap.md`](docs/samantha-app-roadmap.md). The app itself
should live in the separate `BelichickGillisMusk/samantha-agents-google`
repository.

## Start here

Run these from the repo root:

```bash
bash scripts/daily-start.sh
```

Then open:

1. [`docs/quick-reference.md`](docs/quick-reference.md) - the short cheat sheet.
2. [`docs/workflow.md`](docs/workflow.md) - the full daily/weekly process.
3. [`docs/samantha-app-roadmap.md`](docs/samantha-app-roadmap.md) - how to turn
   Samantha into the car-friendly assistant app.

## Repository map

| Path | Purpose |
|------|---------|
| [`README.md`](README.md) | This orientation page |
| [`Claude.md`](Claude.md) | Quick index for AI assistants and humans |
| [`AGENTS.md`](AGENTS.md) | Cursor Cloud runbook and safety notes |
| [`docs/workflow.md`](docs/workflow.md) | Daily, weekly, and project operating rhythm |
| [`docs/quick-reference.md`](docs/quick-reference.md) | Fast prompts, checklists, and commands |
| [`docs/key-operations.md`](docs/key-operations.md) | Copy/paste command reference |
| [`docs/samantha-app-roadmap.md`](docs/samantha-app-roadmap.md) | Build plan for Samantha's app |
| [`scripts/`](scripts/) | Bash helpers for startup, wrap-up, weekly review, and project scaffolds |
| [`templates/`](templates/) | Markdown templates used by scripts and manual notes |
| [`logs/`](logs/) | Local generated logs; contents are intentionally gitignored |

## Script safety

| Script | Safe to run anytime? | What it does |
|--------|----------------------|--------------|
| `bash scripts/daily-start.sh` | Yes | Read-only startup check |
| `bash scripts/daily-end.sh` | Be careful | Creates a daily log, commits, and pushes |
| `bash scripts/weekly-review.sh` | Be careful | Creates a weekly summary, commits, and pushes |
| `bash scripts/new-project.sh "Name"` | Yes | Creates a local gitignored folder under `projects/` |

## Naming note

This repository currently lives at
`BelichickGillisMusk/Claude-Gillis-Musk-Main`. In plain English, treat it as
**Gillis Main**: the main operating manual for Bryan, Samantha, and agents.

## How to update this repo

1. Make the smallest clear change that improves the handbook.
2. Run:
   ```bash
   bash -n scripts/*.sh
   bash scripts/daily-start.sh
   ```
3. Commit with a direct message, for example:
   ```bash
   git commit -m "docs: clarify samantha operating manual"
   ```
