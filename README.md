# mmg-tools

Static HTML tools for Mr Mallorca Golf. Each subfolder is a standalone web app deployed to its own Netlify site, with a custom subdomain on mrmallorcagolf.com.

| Folder | Netlify site | Live URL |
|---|---|---|
| `guide/` | mr-mallorca-golf-course-guides-2026 | guide.mrmallorcagolf.com |
| `calculator/` | mallorca-golf-calculator | deals.mrmallorcagolf.com, calculator.mrmallorcagolf.com |
| `day-cost/` | mmg-day-cost | day-cost.mrmallorcagolf.com |
| `internal/` | mmg-internal | internal.mrmallorcagolf.com |

## Workflow

Edit the HTML file in the relevant folder → commit → push to GitHub → Netlify auto-deploys within ~30 seconds.

```bash
git add .
git commit -m "update calculator"
git push
```

## One-time setup

See SETUP.md for the full GitHub + Netlify + DNS walkthrough.
