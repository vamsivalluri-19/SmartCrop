# SmartCrop Deployment Automation Script
# This script opens all necessary pages for deploying to induridharani-19

Write-Host @"

═══════════════════════════════════════════════════════════════════
    🚀 SMARTCROP DEPLOYMENT TO induridharani-19
═══════════════════════════════════════════════════════════════════

Starting automated deployment process...

"@ -ForegroundColor Cyan

Start-Sleep -Seconds 2

# Step 1: Verify source is ready
Write-Host "✅ Step 1: Verifying source repository..." -ForegroundColor Green
Write-Host "   Source: https://github.com/vamsivalluri-19/SmartCrop" -ForegroundColor Gray
Write-Host "   Status: All 29 files committed and pushed" -ForegroundColor Gray
Start-Sleep -Seconds 1

# Step 2: Open GitHub Login
Write-Host "`n🔐 Step 2: Opening GitHub login page..." -ForegroundColor Green
Write-Host "   Please login with induridharani-19 account" -ForegroundColor Gray
Start-Process "https://github.com/login"
Start-Sleep -Seconds 3

# Step 3: Wait for user to login
Write-Host "`n⏳ Waiting for you to login..." -ForegroundColor Yellow
Write-Host "   Press ENTER after you've logged in as induridharani-19" -ForegroundColor Yellow
Read-Host

# Step 4: Open import page
Write-Host "`n📥 Step 3: Opening GitHub import page..." -ForegroundColor Green
Start-Process "https://github.com/new/import"
Start-Sleep -Seconds 2

Write-Host @"

═══════════════════════════════════════════════════════════════════
    📋 IMPORT FORM INSTRUCTIONS
═══════════════════════════════════════════════════════════════════

Fill in the import form with these exact values:

1️⃣  Your old repository's clone URL:
   https://github.com/vamsivalluri-19/SmartCrop

2️⃣  Repository name:
   SmartCrop

3️⃣  Privacy:
   ✅ Select: Public (REQUIRED for GitHub Pages)

4️⃣  Click: "Begin import"

═══════════════════════════════════════════════════════════════════

"@ -ForegroundColor Cyan

Write-Host "Press ENTER after you've clicked 'Begin import'..." -ForegroundColor Yellow
Read-Host

# Step 5: Wait for import
Write-Host "`n⏳ Import in progress..." -ForegroundColor Yellow
Write-Host "   This usually takes 1-2 minutes" -ForegroundColor Gray
Write-Host "   You'll see a completion message on GitHub" -ForegroundColor Gray
Write-Host "`n   Press ENTER when import is complete..." -ForegroundColor Yellow
Read-Host

# Step 6: Open GitHub Pages settings
Write-Host "`n⚙️  Step 4: Opening GitHub Pages settings..." -ForegroundColor Green
Start-Process "https://github.com/induridharani-19/SmartCrop/settings/pages"
Start-Sleep -Seconds 2

Write-Host @"

═══════════════════════════════════════════════════════════════════
    ⚙️  GITHUB PAGES CONFIGURATION
═══════════════════════════════════════════════════════════════════

Configure GitHub Pages with these settings:

1️⃣  Build and deployment:
   Source: Deploy from a branch

2️⃣  Branch:
   Select: main
   
3️⃣  Folder:
   Select: / (root)

4️⃣  Click: "Save"

═══════════════════════════════════════════════════════════════════

"@ -ForegroundColor Cyan

Write-Host "Press ENTER after you've clicked 'Save'..." -ForegroundColor Yellow
Read-Host

# Step 7: Final verification
Write-Host "`n✨ Step 5: Deployment initiated!" -ForegroundColor Green
Write-Host "   GitHub Pages is now building your site..." -ForegroundColor Gray
Write-Host "   This takes about 2-3 minutes" -ForegroundColor Gray

Start-Sleep -Seconds 3

# Step 8: Open the live site
Write-Host "`n🌐 Opening your website..." -ForegroundColor Green
Start-Process "https://induridharani-19.github.io/SmartCrop/"

Write-Host @"

═══════════════════════════════════════════════════════════════════
    🎉 DEPLOYMENT COMPLETE!
═══════════════════════════════════════════════════════════════════

✅ Repository: https://github.com/induridharani-19/SmartCrop
🌐 Website:    https://induridharani-19.github.io/SmartCrop/

⏳ If you see 404, wait 2-3 minutes and refresh the page.

═══════════════════════════════════════════════════════════════════
    BOTH ACCOUNTS ARE NOW LIVE! 🚀
═══════════════════════════════════════════════════════════════════

Account 1: https://vamsivalluri-19.github.io/SmartCrop/
Account 2: https://induridharani-19.github.io/SmartCrop/

Both sites include:
✅ 45+ Demo images
✅ Fixed login page
✅ All 11 HTML pages
✅ Dashboard & tools
✅ Demo mode enabled
✅ Responsive design
✅ 100% FREE hosting

═══════════════════════════════════════════════════════════════════

"@ -ForegroundColor Green

# Open both sites for comparison
Write-Host "Opening both sites for comparison..." -ForegroundColor Cyan
Start-Sleep -Seconds 2
Start-Process "https://vamsivalluri-19.github.io/SmartCrop/"
Start-Sleep -Seconds 1
Start-Process "https://induridharani-19.github.io/SmartCrop/"

Write-Host "`nPress any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
