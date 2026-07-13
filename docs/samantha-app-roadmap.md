# Samantha App Roadmap

This document turns the Slack idea into a buildable plan:

> Hook up Samantha with an app so Bryan can talk, capture tasks, and get help
> while driving.

## Repository boundary

This repo is the operating manual. The app should be built in:

```text
BelichickGillisMusk/samantha-agents-google
```

Use this document as the source of truth for what the app should do.

## Mission

Samantha is Bryan's voice-first executive assistant. She should help with the
business while Bryan is moving, working, or driving. The first version should do
fewer things reliably instead of trying to connect the whole business at once.

## First useful version

Build the smallest version that can:

1. Let Bryan talk to Samantha from a phone-friendly interface.
2. Turn speech into a task, note, or calendar request.
3. Show Bryan a short confirmation before any risky action.
4. Keep a simple chalkboard task list.
5. Create 17-week retest reminders for completed HD I/M tests.

## Samantha personality rules

- Direct, not robotic.
- Short responses by default.
- When unclear, offer 2-4 choices.
- Confirm before sending messages, changing calendars, creating invoices, or
  contacting customers.
- Remember that Bryan may be driving; do not require typing when a tap or voice
  answer will work.

## Core objects

### Task

- Title
- Notes
- Due date
- Status: `open`, `waiting`, `done`
- Source: voice, chat, email, manual

### Customer test

- Customer / company
- Contact person
- Phone
- Vehicle or unit number
- VIN if available
- Test date
- Result
- Invoice status
- Retest reminder date

### Retest reminder

- Customer
- Vehicle or unit
- Original test date
- Reminder date: original test date plus 17 weeks
- Status: `scheduled`, `sent`, `done`, `cancelled`

## Suggested build phases

### Phase 1: Phone-friendly task capture

Goal: Bryan can open the app, talk, and get a task saved.

Features:

- Big microphone button.
- Transcript preview.
- "Save task" confirmation.
- Chalkboard list of open tasks.
- Manual text fallback.

### Phase 2: Calendar and 17-week reminders

Goal: Samantha can schedule tests and retest reminders.

Features:

- Calendar connection.
- "Schedule a test" flow.
- Completed-test flow.
- Automatic 17-week date calculation.
- Confirmation screen before calendar writes.

### Phase 3: Communication drafts

Goal: Samantha can draft emails or texts without sending blindly.

Features:

- Draft reply from Bryan's voice instruction.
- Show recipient, subject/message, and send options.
- Require confirmation before sending.

### Phase 4: Business integrations

Goal: Connect invoices, customer lookup, DOT lookup, and navigation once the
core assistant is reliable.

Features:

- Invoice draft creation.
- Customer search.
- FMCSA/DOT lookup.
- Directions to next appointment.

## Technical direction

The Slack thread mentioned Google ADK and Gemini. Keep that path unless a later
decision changes it.

Likely pieces:

- Google ADK agent for Samantha's reasoning and tools.
- Phone-friendly web app or mobile wrapper.
- Google Calendar integration.
- Google account auth.
- A small persistent database for tasks and reminders.
- Background job or scheduler for reminder checks.

## Open decisions

Before writing production app code, decide:

1. Web app, native mobile app, or simple mobile-friendly web app first?
2. Where should tasks live long term: app database, Google Tasks, Notion, or
   another existing system?
3. Which calendar account is the source of truth?
4. Which messaging path is allowed first: drafts only, SMS, Gmail, or both?
5. Where should credentials and secrets be stored?

## First prompt for an app-building agent

Use this prompt in the Samantha app repo:

```text
Build the first useful version of Samantha: a phone-friendly voice/task capture
app using the repo's existing stack. Start with a big microphone/text input,
transcript preview, save-to-chalkboard task list, and a safe confirmation model.
Do not send messages or write calendar events yet. Add tests and document setup.
Use docs/samantha-app-roadmap.md from Gillis Main as the product brief.
```

## Acceptance checklist for phase 1

- [ ] Bryan can create a task with text input.
- [ ] Bryan can create a task with voice input if the platform supports it.
- [ ] The app shows open tasks on a chalkboard screen.
- [ ] A saved task persists after refresh.
- [ ] Risky external actions are not implemented yet.
- [ ] Setup instructions are clear enough for a new agent to run.
