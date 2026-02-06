# 🚀 Complete Deployment Guide - SmartCrop

## ✅ Frontend (Already Deployed!)

Your frontend is live at: **https://vamsivalluri-19.github.io/SmartCrop/**

If still showing 404:
1. Go to: https://github.com/vamsivalluri-19/SmartCrop/settings/pages
2. Under "Source": Select **"Deploy from a branch"**
3. Under "Branch": Select **main** and **/ (root)**
4. Click **Save**
5. Wait 1-2 minutes

---

## 🔧 Backend Deployment (100% FREE)

### Option 1: Render.com (Recommended - Easiest)

**Step 1:** Sign up
- Go to: https://render.com
- Click "Get Started for Free"
- Sign up with your GitHub account

**Step 2:** Create New Web Service
1. Click **"New +"** → **"Web Service"**
2. Click **"Connect GitHub"** → Authorize Render
3. Select **"vamsivalluri-19/SmartCrop"** repository
4. Click **"Connect"**

**Step 3:** Configure Service
- **Name:** `smartcrop-backend`
- **Region:** Oregon (US West) - closest to you
- **Branch:** `main`
- **Root Directory:** Leave empty
- **Runtime:** `Python 3`
- **Build Command:** `pip install -r backend/requirements.txt`
- **Start Command:** `cd backend && uvicorn app.main:app --host 0.0.0.0 --port $PORT`
- **Instance Type:** **Free**

**Step 4:** Click "Create Web Service"
- Wait 5-10 minutes for first deployment
- You'll get URL like: `https://smartcrop-backend.onrender.com`
- Copy this URL!

**Step 5:** Update Frontend
- Open: `js/config.js` in your project
- Line 5: Replace URL with your Render URL
- Line 8: Change `DEMO_MODE: true` to `DEMO_MODE: false`
- Save, commit, and push:
  ```bash
  git add js/config.js
  git commit -m "Connect to backend"
  git push origin main
  ```

**Done! Your site is fully functional!**

---

### Option 2: Railway.app (Alternative)

1. Go to: https://railway.app
2. Sign in with GitHub
3. Click **"New Project"** → **"Deploy from GitHub repo"**
4. Select **SmartCrop**
5. Click **"Deploy Now"**
6. Once deployed, click "Settings" → Copy your domain
7. Update `js/config.js` with your Railway URL

---

### Option 3: PythonAnywhere (Traditional)

1. Go to: https://www.pythonanywhere.com
2. Create free account
3. Open Bash console
4. Clone your repo:
   ```bash
   git clone https://github.com/vamsivalluri-19/SmartCrop.git
   cd SmartCrop/backend
   pip install -r requirements.txt
   ```
5. Go to "Web" tab → "Add new web app"
6. Choose "Manual configuration" → Python 3.10
7. Configure WSGI file to run your FastAPI app
8. Get URL and update `js/config.js`

---

## 🎯 Testing Your Deployment

### Test Frontend:
1. Visit: https://vamsivalluri-19.github.io/SmartCrop/
2. Click "Get Started" or "Login"
3. Should see beautiful UI ✅

### Test Backend:
1. Once deployed, visit: `https://your-backend-url.com/docs`
2. You should see API documentation
3. Try the endpoints

### Test Full Integration:
1. Go to your frontend site
2. Register a new account
3. Login
4. Upload an image to crop
5. If everything works → **SUCCESS!** 🎉

---

## 🆘 Troubleshooting

**Frontend 404:**
- Check repository is PUBLIC
- Check GitHub Pages is enabled
- Wait 2-3 minutes after enabling

**Backend not working:**
- Check logs in Render/Railway dashboard
- Verify build command completed successfully
- Check environment variables

**Frontend can't connect to backend:**
- Verify CORS is enabled (already done ✅)
- Check `js/config.js` has correct URL
- Make sure backend URL is HTTPS, not HTTP

---

## 💰 Cost: $0/month (100% FREE!)

- ✅ GitHub Pages: Free static hosting
- ✅ Render Free Tier: 750 hours/month
- ✅ Railway Free Tier: 500 hours/month
- ✅ Your app will sleep after 15 min of inactivity but wakes up automatically

---

## 📧 Need Help?

- Render Docs: https://render.com/docs
- Railway Docs: https://docs.railway.app
- GitHub Pages: https://pages.github.com

---

**Your SmartCrop is ready to use by EVERYONE, ANYWHERE, for FREE! 🌍**
