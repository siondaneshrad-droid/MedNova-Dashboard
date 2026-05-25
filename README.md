# MedNova Partners — Time Clock App
## Deploy Guide (about 10 minutes)

---

### Step 1 — Create a Supabase project

1. Go to https://supabase.com and sign in (or create a free account)
2. Click **New project**
3. Name it `mednova-timeclock`, choose a region close to New York, set a database password
4. Wait ~2 minutes for the project to spin up
5. Go to **SQL Editor** (left sidebar) → click **New query**
6. Paste the entire contents of `supabase-setup.sql` and click **Run**
7. You should see "Success" — your tables and sample employees are created

### Step 2 — Get your Supabase credentials

1. In Supabase go to **Project Settings → API**
2. Copy your **Project URL** (looks like `https://xxxxxxxxxxxx.supabase.co`)
3. Copy your **anon public** key (long string starting with `eyJ...`)

### Step 3 — Add credentials to the app

1. Open `index.html` in a text editor
2. Find these two lines near the top of the `<script>` section:
   ```
   const SUPABASE_URL = 'YOUR_SUPABASE_URL';
   const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
   ```
3. Replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY` with your values
4. Save the file

### Step 4 — Deploy to Netlify

1. Go to https://netlify.com and sign in (or create a free account)
2. Click **Add new site → Deploy manually**
3. Drag and drop the entire `mednova-timeclock-app` folder onto the deploy area
4. Netlify will give you a URL like `https://amazing-name-123.netlify.app`
5. (Optional) Go to **Site settings → Domain management** to set a custom name like `mednova-timeclock.netlify.app`

### Step 5 — Test it

- Open your Netlify URL
- Log in as Admin: ID `ADMIN` / Password `admin123`
- Log in as employee: ID `001` / Password `pass123`
- **Change the admin password first** — go to Admin → Employees, edit the ADMIN user

---

### Updating the app later

If you make changes to `index.html`:
1. Go to your Netlify site dashboard
2. Click **Deploys → Drag and drop** your updated folder

---

### Sharing with employees

Just send them the Netlify URL. They log in with their Employee ID and password.
Works on any phone, tablet, or computer — no app install needed.

---

### Notes

- All clock-in/out times are stored in UTC in Supabase and displayed in local time in the browser
- Passwords are stored as plain text in this version — fine for internal tools, but let us know if you need proper hashing
- The free Supabase tier supports up to 500MB storage and 2GB bandwidth — plenty for a small team
