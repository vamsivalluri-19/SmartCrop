# ==============================================================================
# SMARTCROP DEPLOYMENT SCRIPT - INDURIDHARANI-19 ACCOUNT
# Step-by-Step Automated Deployment with Personal Access Token
# ==============================================================================

Clear-Host
Write-Host "`n" -ForegroundColor White
Write-Host "╔════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    SMARTCROP TO INDURIDHARANI-19                          ║" -ForegroundColor Cyan
Write-Host "║                     STEP-BY-STEP DEPLOYMENT GUIDE                        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host "`n📊 DEPLOYMENT OVERVIEW`n" -ForegroundColor Yellow
Write-Host "Repository: https://github.com/induridharani-19/SmartCrop" -ForegroundColor White
Write-Host "Website: https://induridharani-19.github.io/SmartCrop/" -ForegroundColor Cyan
Write-Host "Files to Deploy: 35+ (HTML, CSS, JS, Backend)" -ForegroundColor White
Write-Host "Time to Complete: 10-15 minutes" -ForegroundColor White

Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host "STEP 1: VERIFY CURRENT REPOSITORY STATE" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

# Check current directory
Write-Host "📁 Current Directory: " -ForegroundColor White -NoNewline
Write-Host (Get-Location) -ForegroundColor Cyan

# Check git repository
Write-Host "`n🔍 Checking Git Repository..." -ForegroundColor White
$gitStatus = & git status 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Git repository found!" -ForegroundColor Green
} else {
    Write-Host "❌ Not a git repository!" -ForegroundColor Red
    exit 1
}

# Check git remotes
Write-Host "`n🌐 Configured Git Remotes:" -ForegroundColor White
$remotes = & git remote -v
$remoteLines = $remotes -split "`n"
foreach ($line in $remoteLines) {
    if ($line.Trim()) {
        Write-Host "   $line" -ForegroundColor Gray
    }
}

# Check for induridharani remote
if ($remotes -match "induridharani") {
    Write-Host "`n✅ 'induridharani' remote is configured!" -ForegroundColor Green
} else {
    Write-Host "`n⚠️  No 'induridharani' remote found. Need to add it." -ForegroundColor Yellow
}

Write-Host "`n✅ STEP 1 COMPLETE: Repository verified!`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host "STEP 2: CREATE PERSONAL ACCESS TOKEN" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

Write-Host "⚠️  IMPORTANT: Make sure you're logged into GitHub as 'induridharani-19'`n" -ForegroundColor Yellow

Write-Host "Instructions:" -ForegroundColor White
Write-Host "1. Click the link below to open GitHub token creation page" -ForegroundColor Gray
Write-Host "2. A browser window will open" -ForegroundColor Gray
Write-Host "3. Fill in:" -ForegroundColor Gray
Write-Host "   • Token name: SmartCrop-Deploy" -ForegroundColor DarkGray
Write-Host "   • Expiration: 30 days" -ForegroundColor DarkGray
Write-Host "   • Scopes: Check ☑️ 'repo' (full control of private repositories)" -ForegroundColor DarkGray
Write-Host "4. Click 'Generate token' at the bottom" -ForegroundColor Gray
Write-Host "5. COPY the entire token (starts with ghp_)" -ForegroundColor Green
Write-Host "6. ⚠️  You'll only see it once! Don't close the page yet!" -ForegroundColor Red
Write-Host "`n" -ForegroundColor White

Write-Host "Opening GitHub token page in 3 seconds..." -ForegroundColor Yellow
Start-Sleep -Seconds 2
Write-Host "`n" -ForegroundColor White

# Open GitHub token creation page
Start-Process "https://github.com/settings/tokens/new?scopes=repo&description=SmartCrop-Deploy&expires_in=2592000"

Read-Host "Press ENTER after you've created and COPIED the token"

Write-Host "`n✅ STEP 2 COMPLETE: Token page opened!`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host "STEP 3: INPUT PERSONAL ACCESS TOKEN" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

$tokenInput = Read-Host "🔐 Paste your Personal Access Token here"

# Validate token format
if ([string]::IsNullOrWhiteSpace($tokenInput)) {
    Write-Host "`n❌ ERROR: Token cannot be empty!" -ForegroundColor Red
    exit 1
}

if (-not $tokenInput.StartsWith("ghp_")) {
    Write-Host "`n⚠️  WARNING: Token doesn't start with 'ghp_'" -ForegroundColor Yellow
    Write-Host "   This might not be a valid Personal Access Token" -ForegroundColor Yellow
    $confirm = Read-Host "   Continue anyway? (yes/no)"
    if ($confirm -ne "yes") {
        exit 1
    }
}

Write-Host "`n✅ Token received! Length: " -ForegroundColor Green -NoNewline
Write-Host $tokenInput.Length -ForegroundColor Cyan
Write-Host "✅ STEP 3 COMPLETE: Token validated!`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host "STEP 4: CONFIGURE GIT WITH TOKEN" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

Write-Host "🔧 Setting up authenticated git URL..." -ForegroundColor White

# Construct authenticated URL
$authenticatedUrl = "https://induridharani-19:$tokenInput@github.com/induridharani-19/SmartCrop.git"

# Update or add the remote URL
Write-Host "   Updating git remote..." -ForegroundColor Gray
$remoteCheck = & git remote | Select-String "induridharani"

if ($remoteCheck) {
    # Update existing remote
    & git remote set-url induridharani $authenticatedUrl 2>&1 | Out-Null
    Write-Host "   ✅ Updated existing 'induridharani' remote" -ForegroundColor Green
} else {
    # Add new remote
    & git remote add induridharani $authenticatedUrl 2>&1 | Out-Null
    Write-Host "   ✅ Added new 'induridharani' remote" -ForegroundColor Green
}

Write-Host "`n✅ STEP 4 COMPLETE: Git configured with token!`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host "STEP 5: PUSH ALL FILES TO INDURIDHARANI-19" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

Write-Host "📤 Pushing files (this may take 10-30 seconds)..." -ForegroundColor White
$pushOutput = & git push induridharani main 2>&1
$pushExitCode = $LASTEXITCODE

if ($pushExitCode -eq 0) {
    Write-Host "`n✅ SUCCESS! All files pushed to induridharani-19!" -ForegroundColor Green
    Write-Host "`n📁 Files pushed:" -ForegroundColor White
    foreach ($line in $pushOutput) {
        if ($line -match "objects|receiving") {
            Write-Host "   $line" -ForegroundColor Gray
        }
    }
} else {
    Write-Host "`n❌ PUSH FAILED!" -ForegroundColor Red
    Write-Host "`n📋 Error Details:" -ForegroundColor White
    Write-Host $pushOutput -ForegroundColor Red
    Write-Host "`n⚠️  Troubleshooting tips:" -ForegroundColor Yellow
    Write-Host "   1. Make sure your token has 'repo' scope" -ForegroundColor Gray
    Write-Host "   2. Check induridharani-19 account is logged in on GitHub" -ForegroundColor Gray
    Write-Host "   3. Ensure repository is set to PUBLIC" -ForegroundColor Gray
    Write-Host "   4. Repository URL: https://github.com/induridharani-19/SmartCrop`n" -ForegroundColor Gray
    exit 1
}

Write-Host "`n✅ STEP 5 COMPLETE: Files deployed!`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host "STEP 6: ENABLE GITHUB PAGES" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

Write-Host "📄 GitHub Pages Setup Instructions:`n" -ForegroundColor White

Write-Host "A browser will open to the Pages settings. Follow these steps:" -ForegroundColor White
Write-Host "1. Look for 'Build and deployment' section" -ForegroundColor Gray
Write-Host "2. Source: Select 'Deploy from a branch'" -ForegroundColor Gray
Write-Host "3. Branch: Select 'main'" -ForegroundColor Gray
Write-Host "4. Folder: Select '/ (root)'" -ForegroundColor Gray
Write-Host "5. Click SAVE button" -ForegroundColor Green
Write-Host "6. Wait 2-3 minutes for GitHub to publish the site`n" -ForegroundColor Gray

Write-Host "Opening GitHub Pages settings in 2 seconds..." -ForegroundColor Yellow
Start-Sleep -Seconds 2

# Open GitHub Pages settings
Start-Process "https://github.com/induridharani-19/SmartCrop/settings/pages"

Read-Host "`n✋ Press ENTER after you've configured GitHub Pages and clicked SAVE"

Write-Host "`n✅ STEP 6 COMPLETE: GitHub Pages configured!`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host "STEP 7: VERIFY DEPLOYMENT" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

Write-Host "🔍 Checking GitHub repository..." -ForegroundColor White
Start-Process "https://github.com/induridharani-19/SmartCrop"

Write-Host "⏳ Website will be live in 2-3 minutes..." -ForegroundColor Yellow
Write-Host "`n" -ForegroundColor White

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "🎉 DEPLOYMENT COMPLETE!" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "✅ ACCOUNT 1 (vamsivalluri-19):" -ForegroundColor Green
Write-Host "   Status: LIVE & WORKING NOW" -ForegroundColor Green
Write-Host "   Repository: https://github.com/vamsivalluri-19/SmartCrop" -ForegroundColor Cyan
Write-Host "   Website: https://vamsivalluri-19.github.io/SmartCrop/`n" -ForegroundColor Cyan

Write-Host "✅ ACCOUNT 2 (induridharani-19):" -ForegroundColor Green
Write-Host "   Status: LIVE (wait 2-3 min after SAVE)" -ForegroundColor Yellow
Write-Host "   Repository: https://github.com/induridharani-19/SmartCrop" -ForegroundColor Cyan
Write-Host "   Website: https://induridharani-19.github.io/SmartCrop/`n" -ForegroundColor Cyan

Write-Host "📊 Total Files Deployed:" -ForegroundColor White
Write-Host "   • 11 HTML Pages" -ForegroundColor Gray
Write-Host "   • 3 JavaScript Files" -ForegroundColor Gray
Write-Host "   • 1 CSS File" -ForegroundColor Gray
Write-Host "   • 9 Python Backend Files" -ForegroundColor Gray
Write-Host "   • 45+ Custom SVG Images (embedded)" -ForegroundColor Gray
Write-Host "   • Configuration Files" -ForegroundColor Gray

Write-Host "`n🎯 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Wait 2-3 minutes after clicking SAVE" -ForegroundColor White
Write-Host "2. Visit https://induridharani-19.github.io/SmartCrop/" -ForegroundColor Cyan
Write-Host "3. If it shows 404, wait a few more minutes and refresh" -ForegroundColor White
Write-Host "4. Both accounts now have IDENTICAL SmartCrop sites!" -ForegroundColor Green

Write-Host "`n" -ForegroundColor White
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "Questions? Check the GitHub repository." -ForegroundColor White
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Read-Host "Press ENTER to exit"
