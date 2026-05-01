# MMG Internal Tools - Project Brief

## Purpose

This app is Andy's internal quote and proposal builder for Mr Mallorca Golf. The main goal is to make it faster to create golfer quotes, understand margin, contact courses, save proposals, and produce client-facing proposal documents without leaving the app.

Live app: https://internal.mrmallorcagolf.com/

## Current Direction

- Keep the flow simple: build the quote first, then polish/export the proposal.
- The proposal should feel client-ready: MMG colours, logo, gold line, readable type, clean A4 layout, and editable wording.
- The app should save time by keeping course rates, discounts, contacts, booking draft emails, saved proposals, and follow-up status in one place.
- Booking workflow with live tee-time availability is deliberately not a priority yet because it would be difficult to keep reliable.

## Key Features Added

- Quote builder with text input parser for dates, courses, times, players, buggies, and clubs.
- Course settings for rack rates, TO discount %, auto cost mode, buggy/club rates, license flag, emails, phones, pricing notes, and contact notes.
- Short course names in the UI, such as Alcanada, Son Servera, and Pula.
- Margin view with green-fee margin, management fee, Andy day fee, and estimated trip profit.
- Proposal output with A4 portrait/landscape PDF layout.
- Proposal wording controls for labels, intro text, notes, footer text, validity/availability/license notes, and client metadata.
- Includes checklist for green fees, buggies, clubs, licenses, planning support, PGA guidance, and custom lines.
- Management fee controls, including percentage values such as 5% or 10%, with options to hide it, include it in the total, or show separately.
- Course booking draft emails with saved course contacts and an optional tour-operator contract reminder.
- Saved quotes page with Supabase sync, statuses, follow-up dates, delete option, backup export/import, and reload.
- PWA/home-screen icon for the internal app.
- Editable PowerPoint export: cover slide, one slide per round, and a summary slide using editable text boxes, image blocks, and shapes.

## Supabase

Project name: `mmg-internal`

Project ID: `ravorybcyptaqoqtxlaw`

Table used: `public.proposals`

The app saves the complete proposal data into the `data` JSON field, with summary fields such as client name, status, next action, follow-up date, first tee date, and total value for searching/filtering.

## Important Files

- `internal/index.html`: main app, styles, data, proposal rendering, saving/loading, Supabase sync, PDF and PowerPoint export.
- `internal/manifest.webmanifest`: PWA/home-screen metadata.
- `internal/icons/`: generated app icons.
- `scripts/generate-internal-pwa-icon.ps1`: icon generation helper.
- `internal/PROJECT_BRIEF.md`: this handover file for future chats.

## Deployment Workflow

Typical workflow:

1. Edit files locally in `c:\Users\andyg\Desktop\cursor\mmg-tools`.
2. Test/build if needed.
3. Commit to git.
4. Push to GitHub on `master`.
5. The live internal site deploys from the connected hosting setup.

## User Preferences

- Practical, fast, low-friction tools over complex workflows.
- Bigger readable text and less wasted space.
- Proposal must remain an A4 document, not a full-width web page.
- Desktop is the primary workflow, but mobile should remain usable.
- Keep internal booking/contact tools clearly separate from the client-facing proposal.
- Avoid confusing terms such as "smart parser"; use simpler labels like "Text Input".

## Future Ideas

- Better page-break checks for multi-page PDF proposals.
- More flexible proposal sections that can be reordered or hidden.
- Course-specific rate rules for unusual contracts and date bands.
- A course contract/rate import helper from spreadsheets or pasted emails.
- More saved email templates for client follow-up, course chasing, accepted proposal, and booked confirmation.
- Optional PowerPoint styling presets for more editorial or more compact proposals.
