# Evening Project Review — 7 PM Agent Skill

Use this skill as the runbook for the **7 PM Daily Project Review** agent for
NorCal CARB Mobile LLC.

## Context

- **Owner:** Bryan Gillis (CEO, mobile CARB testing)
- **Timing:** ~7 PM — Bryan is off the road by ~6 PM, voice-texting from
  couch by 7 PM
- **Purpose:** Bridge the gap between field work and the 9 PM
  invoice-nightly-check cron
- **Companions:** `attention-hq-7am-digest` (morning), `invoice-nightly-check`
  (9 PM)
- **Drive output folder:** `1BNfRFl3EH4cL61UEDBVCEyXgC6F1-oQO`
- **Bryan calendars:** `bgillis99@gmail.com` AND `bryan@norcalcarbmobile.com`
- **Calendar event:** search for `📋 7 PM Daily Project Review` in today's
  events; update its description with the review output

---

## Required MCP Servers

This skill depends on the following MCP servers being connected and
authenticated in Cursor Desktop:

| Server ID | Service | Used for |
|-----------|---------|----------|
| `ca3eea1c-d8b2-4907-ac4e-7b1df7bbd71d` | Google Calendar | list_events, update_event |
| `49a41da9-7b59-4502-954e-d66dc4c5e763` | Gmail | search_threads, create_draft |
| `361bd869-cfd2-4abf-ad58-bdca945227ab` | Stripe | list_invoices, list_payment_intents |
| `session_info` | Cursor Session Info | list_sessions, read_transcript |
| `a0669776-ad19-4500-9ef1-a94724bbbd96` | Google Drive | create_file |

If any server is missing or unauthenticated, the agent should:
1. Log the failure in the `errors` array of the Samantha status JSON.
2. Continue with remaining steps — partial output is better than none.
3. Mark overall status as `PARTIAL` instead of `PASS`.

---

## A+ Customer Flag Rules

A job is flagged **A+** (belongs to Danny at A+ CTC) when **any** of these
conditions is true:

- Customer name matches (case-insensitive, ignore LLC/Inc/Co suffixes):
  - BJ Trucking
  - Bay City Metals
  - Dallinger
  - Granite Bay Bonnie
  - Box Pacific
  - Big Box Stockton
  - Overhead Door Stockton
- Job was booked by `admin@mobilecarbsmoketest.com`

All other jobs are counted as **Direct**.

---

## Execution Steps

### Step 1 — Pull today's completed jobs

Call `list_events` on **both** calendars for today (00:00 → now):

```
Calendar 1: bgillis99@gmail.com
Calendar 2: bryan@norcalcarbmobile.com
Time range: today 00:00:00 to current time
```

Extract from each event:
- Company name (from summary or description)
- Location
- Time
- Truck count (if noted)
- A+ flag (apply rules above)
- Notes

---

### Step 2 — Pull today's sent invoices from Gmail

Run three searches via `search_threads`:

1. `in:sent after:{{TODAY}} (invoice OR INV OR payment OR Stripe)`
2. `in:sent after:{{TODAY}} to:danny@aplusctc.com`
3. `in:sent after:{{TODAY}} (squarespace OR paypal)`

For each result: extract recipient, subject line, snippet. Fuzzy-match each
invoice to a job from Step 1 (case-insensitive, strip LLC/Inc/Co).

---

### Step 3 — Pull Stripe activity today

Call `list_invoices` (limit 25) and `list_payment_intents` (limit 25).

Filter to items created or updated today only. Extract:
- Invoice number
- Customer name
- Amount
- Status (paid / open / draft)

---

### Step 4 — Identify open project items from today's chats

Call `list_sessions` (limit 6). For each session, call `read_transcript`
(limit 6, max_wait_seconds=3).

Scan transcripts for:
- Decisions awaiting an answer
- Promises Bryan made ("I'll send Danny the invoice tomorrow")
- Half-built things (skills mid-creation, scenarios in flight)
- Leads not followed up

---

### Step 5 — Pull tomorrow's calendar preview

Call `list_events` for tomorrow on both calendars. Extract the first 5 jobs
with location and time.

---

### Step 6 — Build the review summary

Use the template in `templates/evening-review.md` to produce the output.
See that file for the exact format.

---

### Step 7 — Update today's 7 PM calendar event

Find today's event with summary containing `📋 7 PM Daily Project Review`.
Call `update_event` — keep the original template at top, append today's
review with a timestamp header:

```
--- Run: YYYY-MM-DD HH:MM ---
[review summary from Step 6]
```

---

### Step 8 — Write HTML infographic

Write to:
`C:\Users\<USERNAME>\OneDrive\Documents\Claude\Outputs\evening-review-YYYY-MM-DD.html`

Use the template in `templates/evening-review.html`. Match the visual style
of `attention-hq-7am-digest`:
- Background: `#0f172a`
- Accent: `#3b82f6`
- Success: `#22c55e`
- Warning: `#f59e0b`
- Error: `#ef4444`

Sections: status badge, job count cards, invoice/payment cards, A+ status
block, gap list with draft buttons, tomorrow preview, prep prompts.

---

### Step 9 — Write Samantha status JSON

Upload to Google Drive folder `1BNfRFl3EH4cL61UEDBVCEyXgC6F1-oQO`.

Filename: `SAMANTHA_STATUS_evening-review_YYYY-MM-DD.json`

Use the template in `templates/samantha-status-evening.json` for the
schema. Always complete this step regardless of earlier failures.

---

### Step 10 — Draft missing A+ invoices to Danny (NEVER SEND)

For each A+ job from Step 1 with no matching invoice in Step 2:
- Call `create_draft` (Gmail)
- **To:** `danny@aplusctc.com`
- **Subject:** `[Customer] — [date] — INV pending`
- **Body:** standard A+ format:
  - Test type (OBD or OVI)
  - Test ID placeholder: `[TEST_ID]`
  - VIN placeholder: `[VIN]`
  - Amount: `$52.30` (OBD default) or `$208.00` (OVI default)
- **Leave as DRAFT** — Bryan reviews and sends manually.

---

## Rules

1. **Awareness mode only** — NEVER send invoices automatically. Drafts only.
2. Match jobs to invoices by company name fuzzy match (case-insensitive,
   ignore LLC/Inc/Co suffixes).
3. A+ flag triggers: see customer list and booking email above.
4. If a session is currently active and contains incomplete work, list it as
   an open project item.
5. Always complete Step 9 (Samantha status file) regardless of other
   failures.
6. All output files go to the OneDrive path — never session-local paths.
7. If an MCP server is unavailable, skip its step, log the error, and
   continue with remaining steps.

---

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| Calendar MCP not responding | Check OAuth token; re-authenticate in Cursor |
| Gmail search returns 0 results | Verify date format `YYYY/MM/DD`; check `in:sent` scope |
| Stripe returns stale data | Confirm API key scope includes `invoices:read` and `payment_intents:read` |
| Session transcripts empty | Increase `max_wait_seconds` to 5; check session is still active |
| Drive upload fails | Verify folder ID `1BNfRFl3EH4cL61UEDBVCEyXgC6F1-oQO` permissions |

---

## How to update this skill

When new A+ customers are added, update the customer list in the
"A+ Customer Flag Rules" section and in `templates/evening-review.html`
(the infographic hardcodes the list for display).

When invoice pricing changes, update the defaults in Step 10 and in
`templates/evening-review.html`.
