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

<<<<<<< HEAD
```
Morning                     During the Day              End of Day
──────────────────────────  ──────────────────────────  ──────────────────────────
1. Review carried tasks      Pick task from backlog      Commit / push WIP
2. Triage email / chat       Feature branch → work       Update daily log
3. Check calendar            Commit often                Clear inbox
4. Set top 3 priorities      Update ticket status        Run daily-end.sh
5. bash scripts/daily-start.sh  Open PR when done        Shut down cleanly

Evening (~7 PM)
──────────────────────────
Agent: evening-project-review-7pm (runs from Cursor Desktop)
Audits: jobs → invoices → Stripe → open items → tomorrow preview
Outputs: calendar update, HTML infographic, Samantha JSON
See: skills/evening-project-review-7pm.md
```
=======
## Say this to Samantha
>>>>>>> origin/main

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

<<<<<<< HEAD
| Type | Use for |
|------|--------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Docs only |
| `chore` | Tooling / deps |
| `refactor` | Code restructure |
| `test` | Tests |

---

## Branch Naming

```
feature/<ticket-id>-short-description
fix/<ticket-id>-short-description
docs/<description>
chore/<description>
```

---

## Scripts Reference

| Script | Run with | What it does |
|--------|----------|-------------|
| `scripts/daily-start.sh` | `bash scripts/daily-start.sh` | Morning checks |
| `scripts/daily-end.sh` | `bash scripts/daily-end.sh` | EOD wrap-up |
| `scripts/weekly-review.sh` | `bash scripts/weekly-review.sh` | Weekly summary |
| `scripts/new-project.sh` | `bash scripts/new-project.sh "Name"` | Scaffold project |

---

## Templates Reference

| Template | Purpose |
|----------|---------|
| `templates/daily-log.md` | Fill in daily |
| `templates/weekly-summary.md` | Fill in weekly |
| `templates/project-brief.md` | New project |
| `templates/meeting-notes.md` | Each meeting |
| `templates/evening-review.md` | 7 PM review summary format |
| `templates/evening-review.html` | 7 PM review HTML infographic |
| `templates/samantha-status-evening.json` | Samantha status schema |

---

## Weekly Review Checklist

- [ ] All open projects reviewed & status updated
- [ ] Backlog groomed and next week prioritized
- [ ] `bash scripts/weekly-review.sh` run
- [ ] Weekly summary sent to stakeholders
- [ ] Monday top-3 priorities set
=======
- [ ] Review customer follow-ups.
- [ ] Confirm every completed test has a 17-week reminder.
- [ ] Review unpaid or unfinished invoices.
- [ ] Review active repos and projects.
- [ ] Pick next week's Top 3 outcomes.
- [ ] Update this handbook if the real workflow changed.
>>>>>>> origin/main
