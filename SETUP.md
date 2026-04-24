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

### Site 2: calculator.mrmallorcagolf.com (new site)

1. https://app.netlify.com → **Add new site → Import an existing project**
2. GitHub → `thattallkid123/mmg-tools`
3. Branch: `master`
4. Base directory: `calculator`
5. Publish directory: `calculator`
6. Build command: *(leave blank)*
7. Click **Deploy site**
8. Once deployed, go to **Domain management → Add custom domain** → `calculator.mrmallorcagolf.com`

### Site 3: day-cost.mrmallorcagolf.com

The existing Netlify site (`mmg-day-cost`) — same as Site 1 above but for day-cost.

1. Go to https://app.netlify.com → open `mmg-day-cost`
2. **Site configuration → Build & deploy → Link repository**
3. GitHub → `thattallkid123/mmg-tools`
4. Branch: `master`
5. Base directory: `day-cost`
6. Publish directory: `day-cost`
7. Build command: *(leave blank)*
8. Click **Save and deploy**

---

## Step 3 — DNS (Cloudflare)

For `calculator.mrmallorcagolf.com` (the new one — the other two already have DNS):

1. Go to Cloudflare → mrmallorcagolf.com → DNS
2. Add a new CNAME record:
   - Type: `CNAME`
   - Name: `calculator`
   - Target: `[your-new-netlify-site-name].netlify.app` (shown in Netlify dashboard)
   - Proxy: **DNS only** (grey cloud) — Netlify handles SSL
3. Save

Then back in Netlify → Domain management → click **Verify DNS** → it'll provision an SSL cert automatically.

---

## After setup: daily workflow

Just edit the file, then:

```bash
cd C:\Users\andyg\Desktop\cursor\mmg-tools
git add .
git commit -m "update guide"
git push
```

All 3 sites check for changes independently — only the site whose folder changed will redeploy.

---

## Future non-MMG projects (e.g. Mallorca Hub)

Same pattern but a separate repo:

1. Create a new GitHub repo (e.g. `mallorca-hub`)
2. Put the HTML as `index.html` in the root
3. Connect to a new Netlify site
4. Use the Netlify URL (e.g. `mallorca-hub.netlify.app`) — no custom domain needed unless you buy one

To update: same git workflow above.
