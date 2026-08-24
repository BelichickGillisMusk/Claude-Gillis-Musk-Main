#!/usr/bin/env bash
# evening-review-7pm.sh — Bryan's 7 PM daily project review runner
# NorCal CARB Mobile LLC — bridges field work and the 9 PM invoice-nightly-check cron
#
# Usage: bash scripts/evening-review-7pm.sh
#
# REQUIRED EXTERNAL MCP SERVERS (must be connected in your Claude.ai environment):
#   mcp__ca3eea1c-d8b2-4907-ac4e-7b1df7bbd71d  Google Calendar (both Bryan calendars)
#   mcp__49a41da9-7b59-4502-954e-d66dc4c5e763  Gmail (in:sent invoice search)
#   mcp__361bd869-cfd2-4abf-ad58-bdca945227ab  Stripe (invoices + payment intents)
#   mcp__session_info                           Claude session transcripts
#   mcp__a0669776-ad19-4500-9ef1-a94724bbbd96  Google Drive (output folder write)
#
# OUTPUT FILES:
#   $ONEDRIVE_OUTPUT/evening-review-YYYY-MM-DD.html
#   Google Drive folder 1BNfRFl3EH4cL61UEDBVCEyXgC6F1-oQO/SAMANTHA_STATUS_evening-review_YYYY-MM-DD.json
#   Calendar event updated: summary contains "📋 7 PM Daily Project Review"
#
# COMPANION AGENTS:
#   attention-hq-7am-digest  (morning)
#   invoice-nightly-check    (9 PM cron)

set -euo pipefail

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

section() { echo -e "\n${CYAN}══ $1 ══${RESET}"; }
ok()      { echo -e "  ${GREEN}✔${RESET}  $1"; }
warn()    { echo -e "  ${YELLOW}⚠${RESET}  $1"; }
err()     { echo -e "  ${RED}✖${RESET}  $1"; }

TODAY=$(date '+%Y-%m-%d')
TODAY_DISPLAY=$(date '+%A, %B %d %Y')
NOW_ISO=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
ONEDRIVE_OUTPUT="C:/Users/ai_he/OneDrive/Documents/Claude/Outputs"
DRIVE_FOLDER="1BNfRFl3EH4cL61UEDBVCEyXgC6F1-oQO"
HTML_OUT="${ONEDRIVE_OUTPUT}/evening-review-${TODAY}.html"
JSON_FILENAME="SAMANTHA_STATUS_evening-review_${TODAY}.json"

# A+ customer list — triggers Danny invoice workflow
APLUS_CUSTOMERS=(
  "BJ Trucking"
  "Bay City Metals"
  "Dallinger"
  "Granite Bay Bonnie"
  "Box Pacific"
  "Big Box Stockton"
  "Overhead Door Stockton"
)

echo -e "${CYAN}"
printf '╔══════════════════════════════════════════════╗\n'
printf "║  🌆 7 PM Evening Review — %-18s  ║\n" "$(date '+%a %b %d')"
printf '╚══════════════════════════════════════════════╝'"${RESET}"$'\n'

# ── STEP 1 — Today's completed jobs from Google Calendar ──────────────────────
section "STEP 1 — Today's Jobs (Calendar)"
echo "  Requires: Google Calendar MCP (mcp__ca3eea1c-d8b2-4907-ac4e-7b1df7bbd71d)"
echo "  Calendars: bgillis99@gmail.com, bryan@norcalcarbmobile.com"
echo "  Query range: ${TODAY} 00:00 → now"
echo "  Extract: company, location, time, truck count, A+ flag, notes"
warn "Run this step via Claude MCP call: list_events on both calendars"

# ── STEP 2 — Sent invoices from Gmail ─────────────────────────────────────────
section "STEP 2 — Sent Invoices (Gmail)"
echo "  Requires: Gmail MCP (mcp__49a41da9-7b59-4502-954e-d66dc4c5e763)"
echo "  Queries:"
echo "    in:sent after:${TODAY} (invoice OR INV OR payment OR Stripe)"
echo "    in:sent after:${TODAY} to:danny@aplusctc.com"
echo "    in:sent after:${TODAY} (squarespace OR paypal)"
echo "  Extract: recipient, subject, snippet, match to STEP 1 jobs (fuzzy name match)"
warn "Run this step via Claude MCP call: search_threads"

# ── STEP 3 — Stripe activity ──────────────────────────────────────────────────
section "STEP 3 — Stripe Activity"
echo "  Requires: Stripe MCP (mcp__361bd869-cfd2-4abf-ad58-bdca945227ab)"
echo "  Calls: list_invoices (limit 25) + list_payment_intents (limit 25)"
echo "  Filter: today-only items"
warn "Run this step via Claude MCP call: list_invoices + list_payment_intents"

# ── STEP 4 — Open project items from today's sessions ─────────────────────────
section "STEP 4 — Open Project Items (Session Transcripts)"
echo "  Requires: Session Info MCP (mcp__session_info)"
echo "  Calls: list_sessions (limit 6), then read_transcript per session"
echo "  Extract: pending decisions, promises Bryan made, half-built items, leads"
warn "Run this step via Claude MCP call: list_sessions + read_transcript"

# ── STEP 5 — Tomorrow's calendar preview ──────────────────────────────────────
section "STEP 5 — Tomorrow's Jobs (Calendar)"
TOMORROW=$(date -d "tomorrow" '+%Y-%m-%d' 2>/dev/null \
           || date -v+1d '+%Y-%m-%d' 2>/dev/null \
           || echo "tomorrow")
echo "  Requires: Google Calendar MCP"
echo "  Query: ${TOMORROW} on both calendars — first 5 jobs"
warn "Run this step via Claude MCP call: list_events for ${TOMORROW}"

# ── STEP 6 — Build review summary ─────────────────────────────────────────────
section "STEP 6 — Review Summary"
echo "  (Populated once Steps 1-5 data is available from MCP calls)"
echo ""
cat <<'TEMPLATE'
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
TEMPLATE

# ── STEP 7 — Update calendar event ────────────────────────────────────────────
section "STEP 7 — Update Calendar Event"
echo "  Requires: Google Calendar MCP"
echo "  Find event: summary contains '📋 7 PM Daily Project Review'"
echo "  Action: update_event — append review to description with timestamp header"
warn "Run this step via Claude MCP call: update_event"

# ── STEP 8 — Write HTML infographic ───────────────────────────────────────────
section "STEP 8 — Write HTML Infographic"
echo "  Output path: ${HTML_OUT}"
echo "  Template: templates/evening-review.html (in this repo)"
echo "  Style: dark #0f172a, accent #3b82f6, success #22c55e, warning #f59e0b, error #ef4444"
echo "  Sections: Status badge | Job count cards | Invoice/payment cards |"
echo "            A+ status block | Gap list | Tomorrow preview | Prep prompts"
warn "Populate with live data then write to OneDrive path"

# ── STEP 9 — Write Samantha status JSON ───────────────────────────────────────
section "STEP 9 — Samantha Status JSON"
echo "  Drive folder: ${DRIVE_FOLDER}"
echo "  Filename: ${JSON_FILENAME}"
warn "Run this step via Claude MCP call: create_file on Drive folder"

# ── STEP 10 — Draft missing A+ invoices (DO NOT SEND) ─────────────────────────
section "STEP 10 — Draft A+ Invoices (Danny) — DRAFTS ONLY"
echo "  Requires: Gmail MCP"
echo "  For each A+ job with no matching sent invoice:"
echo "    To: danny@aplusctc.com"
echo "    Subject: [Customer] — ${TODAY} — INV pending"
echo "    Body: standard A+ format — OBD \$52.30 / OVI \$208.00 default"
echo "  Action: create_draft — Bryan reviews before sending"
echo ""
echo "  A+ trigger customers:"
for c in "${APLUS_CUSTOMERS[@]}"; do
  echo "    · ${c}"
done
echo "    · any booking via admin@mobilecarbsmoketest.com"
warn "Run this step via Claude MCP call: create_draft per missing invoice"

echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${YELLOW}  This script documents the 7 PM review workflow."
echo -e "  To run with live data, execute from your Claude.ai"
echo -e "  environment where the above MCP servers are connected."
echo -e "  See skills/evening-review-7pm.md for full instructions.${RESET}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"

ok "Script complete — MCP environment required for live data collection."
