# Evening Review Template

The agent populates `{{PLACEHOLDERS}}` at runtime. This is the exact output
format for Step 6 of the evening-project-review-7pm skill.

---

```
🌆 EVENING REVIEW — {{DAY_NAME}}, {{DATE}}

JOBS DONE TODAY: {{JOBS_TOTAL}} (A+: {{JOBS_APLUS}} | Direct: {{JOBS_DIRECT}})
{{#EACH JOB}}
- {{CUSTOMER}} | {{LOCATION}} | {{TEST_TYPE}} | {{INVOICE_STATUS}}
{{/EACH}}

INVOICES SENT TODAY: {{INVOICES_SENT}} (~${{INVOICE_TOTAL}} total)
{{#EACH INVOICE}}
- {{SUBJECT}} → {{RECIPIENT}} — ${{AMOUNT}}
{{/EACH}}

PAYMENTS RECEIVED TODAY: ${{PAYMENTS_TOTAL}}
- Stripe: ${{STRIPE_TOTAL}} | PayPal: ${{PAYPAL_TOTAL}} | Other: ${{OTHER_TOTAL}}

INVOICE GAPS (send before bed or 9 PM cron will flag):
{{#EACH GAP}}
- {{CUSTOMER}} — estimated ${{AMOUNT}} — draft ready: {{DRAFT_LINK}}
{{/EACH}}

A+ DANNY STATUS: {{APLUS_JOBS_DONE}} jobs done | {{APLUS_INVOICED}} invoiced to Danny | ${{DANNY_OWED}} owed

OPEN PROJECTS FROM TODAY'S CHATS:
{{#EACH OPEN_PROJECT}}
- {{DESCRIPTION}} — {{SESSION_SOURCE}}
{{/EACH}}

TOMORROW'S PREVIEW:
{{#EACH TOMORROW_JOB}}
- {{TIME}} — {{CUSTOMER}} @ {{LOCATION}}
{{/EACH}}

TOMORROW'S PREP PROMPTS (paste any of these):
1. "Generate Danny catch-up email for this week"
2. "Run VIN compliance check on tomorrow's jobs"
3. "Pull yesterday's Stripe invoices for reconciliation"
END.
```

---

## Field Reference

| Placeholder | Source | Example |
|-------------|--------|---------|
| `{{DAY_NAME}}` | System | `Thursday` |
| `{{DATE}}` | System | `2026-05-21` |
| `{{JOBS_TOTAL}}` | Step 1 calendar count | `7` |
| `{{JOBS_APLUS}}` | Step 1 filtered by A+ rules | `3` |
| `{{JOBS_DIRECT}}` | `JOBS_TOTAL - JOBS_APLUS` | `4` |
| `{{CUSTOMER}}` | Calendar event summary | `BJ Trucking` |
| `{{LOCATION}}` | Calendar event location | `Sacramento, CA` |
| `{{TEST_TYPE}}` | Event description or notes | `OBD` |
| `{{INVOICE_STATUS}}` | Match result from Step 2 | `INVOICED ✅` or `GAP ❌` |
| `{{INVOICES_SENT}}` | Step 2 thread count | `5` |
| `{{INVOICE_TOTAL}}` | Sum of matched amounts | `412.50` |
| `{{SUBJECT}}` | Gmail thread subject | `INV-2026-0521 BJ Trucking` |
| `{{RECIPIENT}}` | Gmail To: field | `danny@aplusctc.com` |
| `{{AMOUNT}}` | Extracted from subject/body | `52.30` |
| `{{PAYMENTS_TOTAL}}` | Step 3 sum | `825.00` |
| `{{STRIPE_TOTAL}}` | Stripe payment_intents succeeded | `625.00` |
| `{{PAYPAL_TOTAL}}` | Gmail PayPal matches | `200.00` |
| `{{OTHER_TOTAL}}` | Remainder | `0.00` |
| `{{DANNY_OWED}}` | A+ jobs invoiced but unpaid | `156.90` |
| `{{DESCRIPTION}}` | Step 4 transcript extraction | `Promised Danny invoice by Friday` |
| `{{SESSION_SOURCE}}` | Session ID or title | `session-abc123` |
| `{{TIME}}` | Tomorrow event start time | `8:00 AM` |
| `{{DRAFT_LINK}}` | Gmail draft link or note | `ask Claude` |
