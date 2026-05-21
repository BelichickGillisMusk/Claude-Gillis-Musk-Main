# 7 PM Evening Review Skill — NorCal CARB Mobile LLC

**Agent:** `evening-project-review-7pm`
**Cadence:** Daily at 7 PM
**Environment:** Claude.ai Desktop with MCP servers connected
**Role:** Bridges field work (Bryan off road by ~6 PM) and the 9 PM `invoice-nightly-check` cron

---

## Required MCP Servers

All five must be connected and authenticated before running:

| MCP Server | ID | Purpose |
|------------|-----|---------|
| Google Calendar | `mcp__ca3eea1c-d8b2-4907-ac4e-7b1df7bbd71d` | Today's + tomorrow's jobs |
| Gmail | `mcp__49a41da9-7b59-4502-954e-d66dc4c5e763` | Sent invoices, A+ draft creation |
| Stripe | `mcp__361bd869-cfd2-4abf-ad58-bdca945227ab` | Payment intents + invoice list |
| Session Info | `mcp__session_info` | Today's chat transcripts for open items |
| Google Drive | `mcp__a0669776-ad19-4500-9ef1-a94724bbbd96` | Write Samantha status JSON to Drive |

**Calendars:** `bgillis99@gmail.com` AND `bryan@norcalcarbmobile.com`
**Drive folder:** `1BNfRFl3EH4cL61UEDBVCEyXgC6F1-oQO`

---

## A+ Customer Trigger List

These customers auto-trigger the Danny invoice workflow (Step 10):

- BJ Trucking
- Bay City Metals
- Dallinger
- Granite Bay Bonnie
- Box Pacific
- Big Box Stockton
- Overhead Door Stockton
- Any booking booked by `admin@mobilecarbsmoketest.com`

---

## Execution Checklist (10 Steps)

### Step 1 — Today's Completed Jobs (Calendar)
```
list_events  →  both calendars  →  TODAY 00:00–now
Extract: company, location, time, truck count, A+ flag, notes
```

### Step 2 — Sent Invoices (Gmail)
```
search_threads  →  in:sent after:[today] (invoice OR INV OR payment OR Stripe)
search_threads  →  in:sent after:[today] to:danny@aplusctc.com
search_threads  →  in:sent after:[today] (squarespace OR paypal)
Fuzzy-match to Step 1 jobs by company name (ignore LLC/Inc, case-insensitive)
```

### Step 3 — Stripe Activity
```
list_invoices (limit 25)         →  filter to today
list_payment_intents (limit 25)  →  filter to today
```

### Step 4 — Open Items from Today's Chats
```
list_sessions (limit 6)
read_transcript per session (limit 6, max_wait_seconds=3)
Extract: pending decisions, Bryan's promises, half-built items, leads
```

### Step 5 — Tomorrow's Calendar Preview
```
list_events  →  both calendars  →  TOMORROW  →  first 5 jobs
```

### Step 6 — Build Review Summary
Populate the following format:

```
🌆 EVENING REVIEW — [day, date]

JOBS DONE TODAY: N (A+: X | Direct: Y)
- [Customer] | [location] | [test] | INVOICED ✅ / GAP ❌

INVOICES SENT TODAY: N (~$X total)
- [INV# or subject] → [recipient] — $[amount]

PAYMENTS RECEIVED TODAY: $X
- Stripe: $X | PayPal: $X | Other: $X

INVOICE GAPS (send before bed or 9 PM cron will flag):
- [Customer] — estimated $X — draft ready: [link or "ask Claude"]

A+ DANNY STATUS: [N jobs done | N invoiced to Danny | $X owed]

OPEN PROJECTS FROM TODAY'S CHATS:
- [item — source session]

TOMORROW'S PREVIEW:
- [first 5 jobs with location/time]

TOMORROW'S PREP PROMPTS (paste any of these):
1. "Generate Danny catch-up email for this week"
2. "Run VIN compliance check on tomorrow's jobs"
3. "Pull yesterday's Stripe invoices for reconciliation"
END.
```

### Step 7 — Update Calendar Event
```
Find event: summary contains "📋 7 PM Daily Project Review"
update_event: append review summary to description, keep original template at top
Add timestamp header to today's run section
```

### Step 8 — Write HTML Infographic
```
Output: C:\Users\ai_he\OneDrive\Documents\Claude\Outputs\evening-review-YYYY-MM-DD.html
Template: templates/evening-review.html (in this repo)
Sections: Status badge | Job cards | Invoice/payment cards | A+ block |
          Gap list with draft buttons | Tomorrow preview | Prep prompts
```

### Step 9 — Write Samantha Status JSON *(always run, even on failure)*
```
Drive folder: 1BNfRFl3EH4cL61UEDBVCEyXgC6F1-oQO
Filename: SAMANTHA_STATUS_evening-review_YYYY-MM-DD.json
Schema: see templates/samantha-status-schema.json or logs/SAMANTHA_STATUS_evening-review_*.json
```

### Step 10 — Draft Missing A+ Invoices (DO NOT SEND)
```
For each A+ job with no matching sent invoice:
  create_draft
    To:      danny@aplusctc.com
    Subject: [Customer] — [YYYY-MM-DD] — INV pending
    Body:    standard A+ format
             Test type: OBD ($52.30) or OVI ($208.00 default)
             Include: test ID placeholder, VIN placeholder
  → Leave as DRAFT — Bryan reviews and sends manually
```

---

## Output Files

| File | Location | Notes |
|------|----------|-------|
| HTML infographic | `C:\Users\ai_he\OneDrive\Documents\Claude\Outputs\evening-review-YYYY-MM-DD.html` | Match dark style |
| Samantha JSON | Google Drive folder `1BNfRFl3EH4cL61UEDBVCEyXgC6F1-oQO` | Always written |
| Repo log (fallback) | `logs/evening-review-YYYY-MM-DD.html` | Committed to repo if OneDrive unavailable |
| Repo Samantha (fallback) | `logs/SAMANTHA_STATUS_evening-review_YYYY-MM-DD.json` | Committed to repo if Drive unavailable |

---

## Billing Rates Reference

| Test Type | Rate |
|-----------|------|
| OBD | $52.30 |
| OVI (default) | $208.00 |

---

## Rules

- **NEVER auto-send invoices.** Only `create_draft`. Bryan reviews before sending.
- Fuzzy company name match: case-insensitive, strip LLC/Inc/Corp suffixes before comparing.
- A+ flag = customer in trigger list OR booked by `admin@mobilecarbsmoketest.com`.
- If a session is active with incomplete work, list it under open projects.
- Step 9 (Samantha JSON) must always run regardless of other failures.
- Status values: `PASS` (all steps complete), `PARTIAL` (some MCP tools unavailable), `FAILED` (critical failure).

---

## Companion Agents

| Agent | Time | Role |
|-------|------|------|
| `attention-hq-7am-digest` | 7 AM | Morning orientation |
| `evening-project-review-7pm` | 7 PM | **This agent** |
| `invoice-nightly-check` | 9 PM | Invoice gap enforcement cron |

---

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| Calendar MCP not found | Verify `mcp__ca3eea1c-...` is connected in Claude.ai settings |
| Stripe `needsAuth` | Open Stripe MCP in Claude.ai → authenticate |
| Drive write fails | Check Drive MCP `mcp__a0669776-...` has write scope for the folder |
| Danny invoice draft not created | Check Gmail MCP is connected; re-run Step 10 manually |
| This script ran in Cursor Cloud Agent | Wrong environment — re-run from Claude.ai Desktop |
