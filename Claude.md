# Claude / Agent Index

This file is the short orientation page for any AI assistant working in this
repository.

## Repository identity

- GitHub repo: `BelichickGillisMusk/Claude-Gillis-Musk-Main`
- Plain-English name: **Gillis Main**
- Purpose: Bryan's operating manual, templates, workflow scripts, and Samantha
  app roadmap.
- Runtime: Bash plus Git only. No app server, no package manager, no build step.

## First moves

Run these before changing anything:

```bash
git status -sb
bash -n scripts/*.sh
```

Use `bash scripts/daily-start.sh` for a safe runtime smoke test. Avoid running
`daily-end.sh` or `weekly-review.sh` unless you intentionally want them to
commit and push.

## Main documents

| Document | Use it for |
|----------|------------|
| [README.md](README.md) | Human-friendly repo overview |
| [docs/quick-reference.md](docs/quick-reference.md) | Fast cheat sheet for Bryan and Samantha |
| [docs/workflow.md](docs/workflow.md) | Full operating rhythm |
| [docs/key-operations.md](docs/key-operations.md) | Command reference |
| [docs/samantha-app-roadmap.md](docs/samantha-app-roadmap.md) | Next build steps for Samantha's car-friendly app |

## Scripts

| Script | Purpose | Side effects |
|--------|---------|--------------|
| [scripts/daily-start.sh](scripts/daily-start.sh) | Morning startup checks | Read-only |
| [scripts/daily-end.sh](scripts/daily-end.sh) | End-of-day wrap-up | Creates log, commits, pushes |
| [scripts/weekly-review.sh](scripts/weekly-review.sh) | Weekly summary generator | Creates summary, commits, pushes |
| [scripts/new-project.sh](scripts/new-project.sh) | Local project scaffold | Writes under gitignored `projects/` |

## Templates

| Template | Purpose |
|----------|---------|
| [templates/daily-log.md](templates/daily-log.md) | Daily operating log |
| [templates/weekly-summary.md](templates/weekly-summary.md) | Weekly review summary |
| [templates/project-brief.md](templates/project-brief.md) | New project brief |
| [templates/meeting-notes.md](templates/meeting-notes.md) | Meeting decisions and action items |

## Style rules for future edits

- Write for Bryan when he is busy, driving, or new to the tool.
- Prefer direct steps over abstract process language.
- Keep secrets out of the repo.
- Put production app code in the correct app repo, not here.
- If a script changes behavior, validate it with `bash -n scripts/*.sh` and a
  safe runtime test.
