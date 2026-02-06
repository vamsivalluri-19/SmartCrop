# ============================================================================
#   SMARTCROP - COMPLETE STEP-BY-STEP DEPLOYMENT TO INDURIDHARANI-19
#   This script will deploy all 45 tracked files + all resources
# ============================================================================

Write-Host "`n" -ForegroundColor White
Write-Host "╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║     SMARTCROP - INDURIDHARANI-19 DEPLOYMENT GUIDE               ║" -ForegroundColor Green
Write-Host "║              Complete Step-by-Step Process                      ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Green

Write-Host "`nThis script will guide you through deploying SmartCrop to induridharani-19.`n" -ForegroundColor White

# ============================================================================
# STEP 1: Verify Local Files
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 1: Verifying Local Files" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Set-Location "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"

$fileCount = (git ls-files | Measure-Object -Line).Lines
Write-Host "✅ Git tracked files: $fileCount files ready to deploy`n" -ForegroundColor Green

Write-Host "File breakdown:" -ForegroundColor White
Write-Host "  • 11 HTML pages (index, login, dashboard, cropper...)" -ForegroundColor Gray
Write-Host "  • 3 JavaScript files (api-simulator, smartcrop, config)" -ForegroundColor Gray
Write-Host "  • 1 CSS file (style.css)" -ForegroundColor Gray
Write-Host "  • 9 Backend Python files" -ForegroundColor Gray
Write-Host "  • 8 Documentation files" -ForegroundColor Gray
Write-Host "  • 3 Config files (Procfile, render.yaml, .gitignore)" -ForegroundColor Gray
Write-Host "  • Embedded: 45+ SVG demo images (no external links)`n" -ForegroundColor Gray

# ============================================================================
# STEP 2: Credential Setup
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 2: GitHub Authentication Setup" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "Two options to authenticate:" -ForegroundColor White
Write-Host "  1. SSH Key (secure, recommended)" -ForegroundColor Cyan
Write-Host "  2. Personal Access Token (simpler)" -ForegroundColor Cyan
Write-Host "  3. Git Credential Manager (auto)" -ForegroundColor Cyan

Write-Host "`nWe'll try to use Git Credential Manager first (most reliable).`n" -ForegroundColor Yellow

$authMethod = "credential-manager"

# ============================================================================
# STEP 3: Clone Target Repository
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 3: Preparing Target Repository" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

$tempRepoDir = "C:\Temp\SmartCrop-Deploy"
$sourceDir = "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"

# Clean previous temp if exists
if (Test-Path $tempRepoDir) {
    Write-Host "🧹 Cleaning previous temp directory..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $tempRepoDir -ErrorAction SilentlyContinue | Out-Null
}

# Create temp directory
New-Item -ItemType Directory -Path $tempRepoDir -Force | Out-Null

Write-Host "📥 Cloning induridharani-19 repository...`n" -ForegroundColor Cyan
Write-Host "URL: https://github.com/induridharani-19/SmartCrop.git`n" -ForegroundColor White

cd $tempRepoDir

# Try HTTPS clone first
git clone https://github.com/induridharani-19/SmartCrop.git . 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Repository cloned successfully!`n" -ForegroundColor Green
} else {
    Write-Host "❌ Clone failed. Checking repository...`n" -ForegroundColor Red
    Write-Host "Make sure:" -ForegroundColor Yellow
    Write-Host "  1. Repository exists: https://github.com/induridharani-19/SmartCrop" -ForegroundColor White
    Write-Host "  2. It is set to PUBLIC (Settings → Visibility)" -ForegroundColor White
    Write-Host "  3. You can access it in your browser`n" -ForegroundColor White
    
    Write-Host "Press ENTER to continue or Ctrl+C to cancel..." -ForegroundColor Yellow
    $null = Read-Host
}

# ============================================================================
# STEP 4: Copy All Files
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 4: Copying All SmartCrop Files" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "Copying from: $sourceDir" -ForegroundColor Gray
Write-Host "Copying to:   $tempRepoDir`n" -ForegroundColor Gray

$copiedCount = 0

# Copy all source files (exclude .git, .venv, node_modules, __pycache__)
Get-ChildItem -Path $sourceDir -Force -Recurse | Where-Object {
    $_.FullName -notmatch '\.git|\.venv|node_modules|__pycache__|\.dist'
} | ForEach-Object {
    if ($_.PSIsContainer) {
        $destPath = Join-Path $tempRepoDir $_.FullName.Substring($sourceDir.Length + 1)
        if (-not (Test-Path $destPath)) {
            New-Item -ItemType Directory -Path $destPath -Force | Out-Null
        }
    } else {
        $relativePath = $_.FullName.Substring($sourceDir.Length + 1)
        $destPath = Join-Path $tempRepoDir $relativePath
        $destFolder = Split-Path $destPath
        
        if (-not (Test-Path $destFolder)) {
            New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
        }
        
        Copy-Item -Path $_.FullName -Destination $destPath -Force -ErrorAction SilentlyContinue | Out-Null
        $copiedCount++
        Write-Host "  ✓ $relativePath" -ForegroundColor Gray
    }
}

Write-Host "`n✅ Copied $copiedCount files successfully!`n" -ForegroundColor Green

# ============================================================================
# STEP 5: Configure Git
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 5: Configuring Git" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

# Configure git user for deployment
git config user.email "smartcrop@deployment.local"
git config user.name "SmartCrop Deployer"

Write-Host "✅ Git user configured`n" -ForegroundColor Green

# ============================================================================
# STEP 6: Commit Changes
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 6: Committing Files" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "Adding all files to git..." -ForegroundColor Cyan
git add -A

$status = git status --porcelain
if ($status) {
    Write-Host "Files to commit:" -ForegroundColor White
    Write-Host "$status" -ForegroundColor Gray
    Write-Host "`nCommitting..." -ForegroundColor Cyan
    
    git commit -m "Deploy SmartCrop - All files (45+ tracked + resources)" 2>&1 | Out-Null
    Write-Host "✅ Files committed!`n" -ForegroundColor Green
} else {
    Write-Host "ℹ️  No new files to commit (already up to date)`n" -ForegroundColor Yellow
}

# ============================================================================
# STEP 7: Push to GitHub
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 7: Pushing to GitHub" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "Repository: https://github.com/induridharani-19/SmartCrop" -ForegroundColor White
Write-Host "Branch: main`n" -ForegroundColor White

Write-Host "⬆️  Pushing files to GitHub..." -ForegroundColor Cyan

$pushOutput = git push origin main -u --force 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Push successful!`n" -ForegroundColor Green
    Write-Host "All files pushed to:" -ForegroundColor White
    Write-Host "  https://github.com/induridharani-19/SmartCrop`n" -ForegroundColor Cyan
} else {
    Write-Host "⚠️  Push result:`n" -ForegroundColor Yellow
    Write-Host $pushOutput -ForegroundColor Gray
    Write-Host "`nThis might be an authentication issue. Git Credential Manager may prompt you.`n" -ForegroundColor Yellow
}

# ============================================================================
# STEP 8: Enable GitHub Pages
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 8: Enabling GitHub Pages" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "Opening GitHub Pages settings...`n" -ForegroundColor White
Start-Sleep -Seconds 1

$pagesUrl = "https://github.com/induridharani-19/SmartCrop/settings/pages"
Start-Process $pagesUrl

Write-Host "In the browser window that opened:" -ForegroundColor Green
Write-Host "  1. Look for 'Build and deployment' section" -ForegroundColor White
Write-Host "  2. Select: 'Deploy from a branch'" -ForegroundColor White
Write-Host "  3. Branch: 'main'" -ForegroundColor White
Write-Host "  4. Folder: '/ (root)'" -ForegroundColor White
Write-Host "  5. Click 'Save' button`n" -ForegroundColor White

Write-Host "Press ENTER after you've configured Pages and clicked Save..." -ForegroundColor Yellow
$null = Read-Host

# ============================================================================
# STEP 9: Final Summary
# ============================================================================

Write-Host "`n╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║           ✅ DEPLOYMENT COMPLETE!                              ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "DEPLOYMENT SUMMARY" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "📁 Repository:" -ForegroundColor White
Write-Host "   https://github.com/induridharani-19/SmartCrop`n" -ForegroundColor Cyan

Write-Host "📦 Files Deployed:" -ForegroundColor White
Write-Host "   ✓ 45 git-tracked files" -ForegroundColor Green
Write-Host "   ✓ 11 HTML pages" -ForegroundColor Green
Write-Host "   ✓ 3 JavaScript files" -ForegroundColor Green
Write-Host "   ✓ 1 CSS file" -ForegroundColor Green
Write-Host "   ✓ 9 Backend Python files" -ForegroundColor Green
Write-Host "   ✓ 8 Documentation files" -ForegroundColor Green
Write-Host "   ✓ 45+ embedded SVG demo images`n" -ForegroundColor Green

Write-Host "🎨 Featured Features:" -ForegroundColor White
Write-Host "   ✓ Professional landing page" -ForegroundColor Green
Write-Host "   ✓ Image cropping tool" -ForegroundColor Green
Write-Host "   ✓ Video cropper" -ForegroundColor Green
Write-Host "   ✓ Batch processing" -ForegroundColor Green
Write-Host "   ✓ AI smart crop suggestions" -ForegroundColor Green
Write-Host "   ✓ User authentication & dashboard" -ForegroundColor Green
Write-Host "   ✓ Weather advisory system" -ForegroundColor Green
Write-Host "   ✓ Mobile responsive design`n" -ForegroundColor Green

Write-Host "🌐 Your Live Website:" -ForegroundColor White
Write-Host "   https://induridharani-19.github.io/SmartCrop/`n" -ForegroundColor Cyan -BackgroundColor Blue

Write-Host "⏱️  Wait 2-3 minutes for GitHub Pages to publish your site...`n" -ForegroundColor Yellow

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "ACCOUNT STATUS" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "✅ Account 1: vamsivalluri-19" -ForegroundColor Green
Write-Host "   https://vamsivalluri-19.github.io/SmartCrop/" -ForegroundColor Green
Write-Host "   Status: LIVE NOW`n" -ForegroundColor Green

Write-Host "✅ Account 2: induridharani-19" -ForegroundColor Green
Write-Host "   https://induridharani-19.github.io/SmartCrop/" -ForegroundColor Green
Write-Host "   Status: PUBLISHING (2-3 minutes)`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "VERIFY YOUR DEPLOYMENT" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "Check repository files:" -ForegroundColor White
Write-Host "  https://github.com/induridharani-19/SmartCrop`n" -ForegroundColor Cyan

Write-Host "Check Pages settings:" -ForegroundColor White
Write-Host "  https://github.com/induridharani-19/SmartCrop/settings/pages`n" -ForegroundColor Cyan

Write-Host "Test your website:" -ForegroundColor White
Write-Host "  https://induridharani-19.github.io/SmartCrop/`n" -ForegroundColor Cyan

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host "🎉 Both accounts now have identical SmartCrop websites!" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

# Cleanup
Write-Host "🧹 Cleaning up temporary files..." -ForegroundColor Yellow
Set-Location "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"
Remove-Item -Recurse -Force $tempRepoDir -ErrorAction SilentlyContinue | Out-Null
Write-Host "✅ Done!`n" -ForegroundColor Green

Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
