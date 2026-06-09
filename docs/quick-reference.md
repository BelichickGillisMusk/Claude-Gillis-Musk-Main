# Quick Reference

Fast commands and prompts for Gillis Main. Full details live in
[`workflow.md`](workflow.md), [`key-operations.md`](key-operations.md), and
[`samantha-app-roadmap.md`](samantha-app-roadmap.md).

## Daily flow

| Moment | Do this |
|--------|---------|
| Morning | `bash scripts/daily-start.sh` |
| Before work | Pick the Top 3 priorities |
| During day | Capture tasks immediately; organize later |
| Customer passed | Schedule the 17-week retest reminder |
| End of day | Fill daily log and carry unfinished items forward |
| Friday | Review projects, reminders, invoices, and next week's Top 3 |

## Say this to Samantha

| Need | Voice prompt |
|------|--------------|
| Add a task | "Add to the chalkboard: ..." |
| Schedule work | "Schedule a test for [customer] on [day/time]." |
| Retest | "Customer passed. Set the 17-week reminder." |
| Email | "Draft a reply saying ..." |
| Invoice | "Create an invoice for ..." |
| Lookup | "Find the DOT number for ..." |
| Navigation | "Get directions to ..." |

If Samantha is unsure, she should give 2-4 tap choices instead of a long
question.

## Repo commands

```bash
# See current state
git status -sb

# Validate scripts
bash -n scripts/*.sh

# Safe runtime check
bash scripts/daily-start.sh
```

## Scripts

| Script | Command | Warning |
|--------|---------|---------|
| Daily start | `bash scripts/daily-start.sh` | Safe/read-only |
| Daily end | `bash scripts/daily-end.sh` | Commits and pushes |
| Weekly review | `bash scripts/weekly-review.sh` | Commits and pushes |
| New project | `bash scripts/new-project.sh "Name"` | Writes under gitignored `projects/` |

## Git basics

```bash
git checkout -b docs/clear-name
git add -p
git commit -m "docs: clear description"
git push -u origin docs/clear-name
```

Commit types:

- `docs:` documentation
- `fix:` broken behavior
- `feat:` new ability
- `chore:` maintenance

## Weekly checklist

- [ ] Review customer follow-ups.
- [ ] Confirm every completed test has a 17-week reminder.
- [ ] Review unpaid or unfinished invoices.
- [ ] Review active repos and projects.
- [ ] Pick next week's Top 3 outcomes.
- [ ] Update this handbook if the real workflow changed.
