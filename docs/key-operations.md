# Key Operations

This is the copy/paste reference for common work in Gillis Main. Commands are
grouped by what Bryan or an assistant is trying to do.

## Safety rules

- If a command deletes, overwrites, commits, pushes, sends, or publishes, pause
  and make sure that is really the goal.
- Never paste secrets into a repository.
- Prefer reviewing changes before committing them.
- Use the Samantha app roadmap for app work; use this repo for docs, templates,
  scripts, and plans.

---

## Repository basics

```bash
# Where am I?
pwd

# What changed?
git status -sb

# What branch am I on?
git branch --show-current

# What files changed?
git diff --stat

# Review the actual change
git diff
```

## Safe validation for this repo

```bash
# Check Bash syntax without running mutating scripts
bash -n scripts/*.sh

# Safe read-only smoke test
bash scripts/daily-start.sh
```

Avoid these unless you want commits and pushes:

```bash
bash scripts/daily-end.sh
bash scripts/weekly-review.sh
```

---

## Git workflow

```bash
# Start a new branch
git checkout -b docs/clear-description

# Stage selected pieces
git add -p

# Or stage specific files
git add README.md docs/workflow.md

# Commit
git commit -m "docs: clarify main operating workflow"

# Push the branch
git push -u origin docs/clear-description
```

### Commit message types

| Type | Use it for |
|------|------------|
| `docs` | Markdown or instructions |
| `fix` | Correct broken behavior |
| `feat` | Add a new user-facing ability |
| `chore` | Maintenance and housekeeping |
| `refactor` | Reorganize without changing behavior |
| `test` | Add or update tests |

---

## Finding files and text

Use these when the repo gets bigger:

```bash
# List files in the current folder
ls

# Find files by name with ripgrep
rg --files | rg 'workflow|samantha|script'

# Search inside files
rg "17-week|Samantha|daily-start"

# Search Markdown only
rg "retest" -g "*.md"
```

If you are inside Cursor Cloud as an agent, prefer the built-in file search and
read tools over shell file reads.

---

## Working with daily notes

```bash
# Start the day
bash scripts/daily-start.sh

# Create a local project plan
bash scripts/new-project.sh "Samantha Voice App"

# End the day only when ready for commits/pushes
bash scripts/daily-end.sh
```

Daily and weekly generated logs are ignored by git:

- `logs/daily/*.md`
- `logs/weekly/*.md`

That keeps private scratch notes local by default.

---

## Samantha operating prompts

These are examples Bryan can say once Samantha is connected to the right tools:

| Need | Say |
|------|-----|
| Capture a task | "Add to the chalkboard: call Alex about the test." |
| Schedule test | "Schedule an HD I/M test for Tuesday at 9." |
| Retest reminder | "Customer passed. Set the 17-week reminder." |
| Email draft | "Draft a reply saying Thursday morning works." |
| Invoice | "Create the invoice for today's test." |
| Company lookup | "Look up the DOT number for this company." |
| Navigation | "Get directions to the next test." |

Samantha should confirm risky actions before sending, posting, charging, or
deleting anything.

---

## File and system commands

```bash
# Show disk space
df -h

# Show size of items in current directory
du -sh *

# Create folders
mkdir -p path/to/folder

# Copy a file
cp source.md destination.md

# Move or rename a file
mv old-name.md new-name.md
```

Deletion commands are intentionally not listed as defaults. If you need to
delete something, check the path twice and use the least destructive command.

---

## GitHub CLI notes

For normal local use, `gh` can inspect and manage GitHub. In some agent
environments it may be read-only.

```bash
# See repo info
gh repo view

# See pull requests
gh pr list

# View a pull request
gh pr view <number>
```

If an agent needs to create a pull request in Cursor Cloud, use the provided PR
tool instead of `gh pr create`.
