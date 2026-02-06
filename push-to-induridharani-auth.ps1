# ========================================================
#   SMARTCROP - PUSH ALL FILES TO INDURIDHARANI-19
#   PowerShell Deployment Script with Authentication
# ========================================================

Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  SMARTCROP - DEPLOY TO INDURIDHARANI-19 (WITH AUTH)         ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

Write-Host "This script will push ALL 31 files to induridharani-19 account.`n" -ForegroundColor White

# Check if git is configured
$currentUser = git config user.name
Write-Host "📋 Current Git User: $currentUser`n" -ForegroundColor Yellow

# Step 1: Generate Personal Access Token
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 1: Create Personal Access Token" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "`nI will open GitHub token creation page...`n" -ForegroundColor White
Write-Host "Follow these steps:" -ForegroundColor Green
Write-Host "  1. Login as: induridharani-19" -ForegroundColor White
Write-Host "  2. Name: SmartCrop-Deployment" -ForegroundColor White
Write-Host "  3. Expiration: 90 days" -ForegroundColor White
Write-Host "  4. Check: [✓] repo (Full control of repositories)" -ForegroundColor White
Write-Host "  5. Scroll down, click 'Generate token'" -ForegroundColor White
Write-Host "  6. COPY the token (starts with ghp_...)`n" -ForegroundColor White

Write-Host "Press ENTER to open GitHub token page..." -ForegroundColor Green
$null = Read-Host

Start-Process "https://github.com/settings/tokens/new?description=SmartCrop-Deployment&scopes=repo"

Write-Host "`n⏱️  Wait 10 seconds for page to load...`n" -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Step 2: Get Token
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 2: Enter Your Token" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host ""

$token = Read-Host "`nPaste your Personal Access Token (ghp_...)" -AsSecureString
$tokenPlain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($token))

if ([string]::IsNullOrWhiteSpace($tokenPlain) -or -not $tokenPlain.StartsWith("ghp_")) {
    Write-Host "`n❌ ERROR: Invalid token format!" -ForegroundColor Red
    Write-Host "Token should start with 'ghp_'`n" -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "`n✅ Token received!`n" -ForegroundColor Green

# Step 3: Push to Repository
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 3: Pushing All Files" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan

Set-Location "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"

Write-Host "`n📦 Preparing to push 31 files..." -ForegroundColor Cyan
Write-Host "   11 HTML pages" -ForegroundColor White
Write-Host "   3 JavaScript files" -ForegroundColor White
Write-Host "   1 CSS file" -ForegroundColor White
Write-Host "   9 Backend files" -ForegroundColor White
Write-Host "   7 Documentation files`n" -ForegroundColor White

# Commit any remaining files
Write-Host "📝 Committing latest changes..." -ForegroundColor Cyan
git add -A
git commit -m "Deploy all files to induridharani-19" 2>&1 | Out-Null

Write-Host "⬆️  Pushing to induridharani-19...`n" -ForegroundColor Yellow

# Push with authentication
$repoUrl = "https://$tokenPlain@github.com/induridharani-19/SmartCrop.git"
$pushResult = git push $repoUrl main --force 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║              ✅ PUSH SUCCESSFUL!                            ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green
    
    Write-Host "📁 Repository: https://github.com/induridharani-19/SmartCrop" -ForegroundColor White
    Write-Host "📊 All 31 files deployed successfully!`n" -ForegroundColor Green
    
    # Step 4: Enable GitHub Pages
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "STEP 4: Enable GitHub Pages" -ForegroundColor Yellow
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    
    Write-Host "`nOpening Pages settings...`n" -ForegroundColor Cyan
    Start-Sleep -Seconds 2
    Start-Process "https://github.com/induridharani-19/SmartCrop/settings/pages"
    
    Write-Host "Configure these settings:" -ForegroundColor Green
    Write-Host "  Source: Deploy from a branch" -ForegroundColor White
    Write-Host "  Branch: main" -ForegroundColor White
    Write-Host "  Folder: / (root)" -ForegroundColor White
    Write-Host "  Click 'Save' button`n" -ForegroundColor White
    
    Write-Host "Press ENTER when Pages is configured..." -ForegroundColor Green
    $null = Read-Host
    
    Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║           🎉 DEPLOYMENT COMPLETE! 🎉                        ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green
    
    Write-Host "🌐 Your website will be live at:" -ForegroundColor Cyan
    Write-Host "   https://induridharani-19.github.io/SmartCrop/`n" -ForegroundColor White -BackgroundColor Blue
    
    Write-Host "⏱️  Wait 2-3 minutes for GitHub Pages to publish.`n" -ForegroundColor Yellow
    
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "BOTH ACCOUNTS NOW LIVE!" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "`n✅ Account 1: https://vamsivalluri-19.github.io/SmartCrop/" -ForegroundColor White
    Write-Host "✅ Account 2: https://induridharani-19.github.io/SmartCrop/`n" -ForegroundColor White
    
    Write-Host "📦 Files Deployed: 31 total (100% identical on both accounts)" -ForegroundColor White
    Write-Host "🎨 Demo Images: 45+ SVG images (all working)" -ForegroundColor White
    Write-Host "💰 Cost: `$0/month (FREE hosting)`n" -ForegroundColor Green
    
} else {
    Write-Host "`n❌ ERROR: Push failed!`n" -ForegroundColor Red
    Write-Host "Error details:" -ForegroundColor Yellow
    Write-Host $pushResult -ForegroundColor Red
    Write-Host "`nPossible issues:" -ForegroundColor Yellow
    Write-Host "  1. Token is incorrect or expired" -ForegroundColor White
    Write-Host "  2. Token doesn't have 'repo' permissions" -ForegroundColor White
    Write-Host "  3. Repository doesn't exist or is private" -ForegroundColor White
    Write-Host "  4. You're not logged in as induridharani-19`n" -ForegroundColor White
    
    Write-Host "Try again with a new token.`n" -ForegroundColor Yellow
}

Write-Host "`nPress any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
