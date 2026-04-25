# One-time Setup: GitHub → Netlify → Custom Domain

Do this once. After this, every push to GitHub auto-deploys all three sites.

---

## Step 1 — Create the GitHub repo

1. Go to https://github.com/new
2. Name: `mmg-tools`
3. Set to **Private** (or Public — your call)
4. Do NOT initialise with README (we already have one)
5. Click **Create repository**

Then in your terminal (the mmg-tools folder is already a git repo):

```bash
cd C:\Users\andyg\Desktop\cursor\mmg-tools
git remote add origin https://github.com/thattallkid123/mmg-tools.git
git push -u origin master
```

---

## Step 2 — Connect each Netlify site to GitHub

Do this for each of the 3 sites. The key step is setting the **Base directory** so each Netlify site only watches its own subfolder.

### Site 1: guide.mrmallorcagolf.com

The existing Netlify site (`mr-mallorca-golf-course-guides-2026`) is currently on manual deploy.
You need to link it to GitHub instead.

1. Go to https://app.netlify.com → open `mr-mallorca-golf-course-guides-2026`
2. **Site configuration → Build & deploy → Link repository**
3. Choose GitHub → `thattallkid123/mmg-tools`
4. Branch: `master`
5. Base directory: `guide`
6. Publish directory: `guide`
7. Build command: *(leave blank)*
8. Click **Save and deploy**

### Site 2: deals.mrmallorcagolf.com and calculator.mrmallorcagolf.com

The existing Netlify site (`mallorca-golf-calculator`) — link it to GitHub.

1. Go to https://app.netlify.com → open `mallorca-golf-calculator`
2. **Site configuration → Build & deploy → Link repository**
3. Choose GitHub → `thattallkid123/mmg-tools`
4. Branch: `master`
5. Base directory: `calculator`
6. Publish directory: `calculator`
7. Build command: *(leave blank)*
8. Click **Save and deploy**
9. Domain management → Add custom domain → `deals.mrmallorcagolf.com`
10. Domain management → Add domain alias → `calculator.mrmallorcagolf.com`

### Site 3: day-cost.mrmallorcagolf.com

The existing Netlify site (`mmg-day-cost`) — same process.

1. Go to https://app.netlify.com → open `mmg-day-cost`
2. **Site configuration → Build & deploy → Link repository**
3. Choose GitHub → `thattallkid123/mmg-tools`
4. Branch: `master`
5. Base directory: `day-cost`
6. Publish directory: `day-cost`
7. Build command: *(leave blank)*
8. Click **Save and deploy**
9. Domain management → Add custom domain → `day-cost.mrmallorcagolf.com`

---

## Step 3 — DNS (Cloudflare)

For each subdomain, add a CNAME in Cloudflare → mrmallorcagolf.com → DNS:

| Name | Target | Proxy |
|---|---|---|
| `deals` | `mallorca-golf-calculator.netlify.app` | DNS only (grey) |
| `calculator` | `mallorca-golf-calculator.netlify.app` | DNS only (grey) |
| `day-cost` | `mmg-day-cost.netlify.app` | DNS only (grey) |
| `guide` | `mr-mallorca-golf-course-guides-2026.netlify.app` | DNS only (grey) |

Then in each Netlify site → Domain management → **Verify DNS configuration** → SSL provisions automatically.

---

## After setup: daily workflow

Edit the file in the relevant folder, then:

```bash
cd C:\Users\andyg\Desktop\cursor\mmg-tools
git add .
git commit -m "update guide"
git push
```

All 3 sites deploy independently — only the folder that changed will redeploy.

---

## Future non-MMG projects (e.g. Mallorca Hub)

Same pattern but a separate repo:

1. Create a new GitHub repo (e.g. `mallorca-hub`)
2. Put the HTML as `index.html` in the root
3. Connect to a new Netlify site
4. Use the Netlify URL (e.g. `mallorca-hub.netlify.app`) — no custom domain needed unless you buy one

To update: same git workflow above.
