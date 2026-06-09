# Gillis Main Workflow

This is the operating rhythm for Bryan, Samantha, and any AI assistant helping
with the business. The point is not to be fancy. The point is to capture work,
finish the right things, and avoid losing important follow-ups.

## Operating principles

1. **Capture first, organize second.** If Bryan says a task while driving, get it
   written down immediately.
2. **Use tap choices when unclear.** Samantha should offer 2-4 direct options
   instead of asking open-ended questions when Bryan is busy.
3. **Protect the 17-week rule.** Every completed HD I/M test needs a retest
   reminder scheduled 17 weeks later unless Bryan says otherwise.
4. **Keep repos separated.** This repo is the handbook. App code belongs in the
   app repo.
5. **No secrets in git.** Credentials live in the proper cloud or local secret
   store, never in Markdown.

---

## 1. Morning startup

**Goal:** Know what matters today before the day starts running you.

1. Run the safe startup check:
   ```bash
   bash scripts/daily-start.sh
   ```
2. Review yesterday's carry-overs.
3. Check the calendar for tests, calls, deadlines, and family commitments.
4. Check messages that can change today's plan.
5. Pick the **Top 3**:
   - one must-do customer/business item,
   - one follow-up/admin item,
   - one build/improvement item if there is capacity.
6. Put the Top 3 in today's daily log.

Daily logs are generated under `logs/daily/` and are gitignored so private
working notes do not get pushed by accident.

---

## 2. While driving or working

**Goal:** Make Samantha useful without forcing Bryan to type.

Use short commands:

- "Samantha, add this to the chalkboard: call Mike about the invoice."
- "Schedule a test for Tuesday at 9."
- "Customer passed. Set the 17-week retest reminder."
- "Find the DOT number for this company."
- "Draft a reply saying I can do Thursday morning."

Samantha should respond with one of these patterns:

| Situation | Best response |
|-----------|---------------|
| Clear task | "Done." Then summarize the action. |
| Needs a choice | "Pick one: A, B, or C." |
| Risky or external action | "I can draft it. Confirm before I send." |
| Missing critical info | Ask one short question. |

---

## 3. Customer test workflow

**Goal:** Every test creates the right paperwork, schedule entry, and follow-up.

1. Capture customer and vehicle details.
2. Put the test on the calendar.
3. Complete the test.
4. Create or update the invoice.
5. Record the result.
6. If the test is complete, schedule the 17-week retest reminder.
7. Add unresolved items to the chalkboard.

Minimum fields to capture:

- Customer / company name
- Contact name and phone
- Vehicle or unit number
- VIN if available
- Test date
- Result
- Invoice status
- Retest reminder date

---

## 4. Project workflow

**Goal:** Make progress without mixing experiments, docs, and production code.

### Use this repo when the work is:

- a process note,
- a template,
- a script for daily workflow,
- a roadmap or project brief.

### Use another repo when the work is:

- production app code,
- website code,
- a customer-specific system,
- a serious experiment that needs its own history.

For new local planning work:

```bash
bash scripts/new-project.sh "Project Name"
```

This creates a gitignored folder under `projects/` so you can think without
accidentally committing private drafts.

### Code branch habit

```bash
git checkout -b docs/clear-description
git status -sb
git add -p
git commit -m "docs: clear description"
git push -u origin docs/clear-description
```

For Cursor Cloud work, follow the branch naming requested by the cloud task.

---

## 5. End-of-day wrap-up

**Goal:** Leave tomorrow a clean starting point.

1. Move unfinished work to tomorrow with a note.
2. Fill out today's daily log:
   - wins,
   - customer follow-ups,
   - blockers,
   - tomorrow's carry-overs.
3. If you intentionally want the script to commit and push, run:
   ```bash
   bash scripts/daily-end.sh
   ```
4. Check that any customer action with a date is on the calendar.
5. Close unused tabs and apps.

Important: `daily-end.sh` commits and pushes. Do not run it as a harmless test.

---

## 6. Weekly review

**Goal:** Turn the week into a short, useful summary and a better next week.

1. Review daily logs.
2. Review open customer follow-ups.
3. Check whether every completed test has its retest reminder.
4. Review active projects and decide:
   - continue,
   - pause,
   - finish,
   - delete.
5. Generate the weekly summary only when you are ready for it to commit:
   ```bash
   bash scripts/weekly-review.sh
   ```
6. Pick next week's Top 3 outcomes.

Important: `weekly-review.sh` writes under `logs/weekly/`, commits, and pushes.

---

## 7. Monthly cleanup

**Goal:** Keep the system from turning into another messy pile.

1. Archive or delete stale drafts.
2. Check active repos and make sure each has a clear purpose.
3. Update this handbook if the real workflow changed.
4. Review Samantha's missing abilities and add them to the roadmap.
5. Check credential hygiene: no keys in repos, old tokens rotated, access still
   limited to what is needed.

---

## 8. When an AI assistant takes over

The assistant should:

1. Read `README.md`, `Claude.md`, and this workflow.
2. Run:
   ```bash
   git status -sb
   bash -n scripts/*.sh
   ```
3. Avoid mutating scripts unless that is the assignment.
4. If the request is really app work for Samantha, use
   `docs/samantha-app-roadmap.md` and the app repo instead of stuffing app code
   into this handbook.
