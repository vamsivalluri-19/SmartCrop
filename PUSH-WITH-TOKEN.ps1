# This script uploads all files to induridharani-19 using authentication

Write-Host "`n╔══════════════════════════════════════════════════════════════════╗`n" -ForegroundColor Green
Write-Host "   SMARTCROP - PUSH TO INDURIDHARANI-19 (AUTHENTICATED)           `n" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

$repoUrl = "https://github.com/induridharani-19/SmartCrop.git"

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "AUTHENTICATION" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "You need to create a Personal Access Token for induridharani-19.`n" -ForegroundColor White

Write-Host "STEP 1: Create Personal Access Token" -ForegroundColor Green
Write-Host "  Go to: https://github.com/settings/tokens/new" -ForegroundColor Cyan
Write-Host "  (Make sure you're logged in as induridharani-19!)`n" -ForegroundColor Yellow

Write-Host "STEP 2: Configure Token" -ForegroundColor Green
Write-Host "  Name: SmartCrop-Deploy" -ForegroundColor Cyan
Write-Host "  Expiration: 90 days" -ForegroundColor Cyan
Write-Host "  Scopes: Check 'repo' (Full control of repositories)" -ForegroundColor Cyan
Write-Host "  Click 'Generate token'`n" -ForegroundColor Cyan

Write-Host "STEP 3: Copy Token" -ForegroundColor Green
Write-Host "  Token starts with: ghp_" -ForegroundColor Cyan
Write-Host "  (You'll only see it once!)`n" -ForegroundColor Yellow

Write-Host "Opening GitHub token creation page...`n" -ForegroundColor Yellow
Start-Sleep -Seconds 2
Start-Process "https://github.com/settings/tokens/new?description=SmartCrop-Deploy&scopes=repo"

Write-Host "STEP 4: Enter Your Token" -ForegroundColor Green
Write-Host ""

$token = Read-Host "Paste your Personal Access Token (starts with ghp_)"

if ([string]::IsNullOrWhiteSpace($token)) {
    Write-Host "`n❌ No token provided. Exiting.`n" -ForegroundColor Red
    exit 1
}

if (-not $token.StartsWith("ghp_")) {
    Write-Host "`n❌ Invalid token format (should start with ghp_). Exiting.`n" -ForegroundColor Red
    exit 1
}

Write-Host "`n✅ Token received!`n" -ForegroundColor Green

# Now push using the token
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "PUSHING FILES" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Set-Location "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"

# Update remote URL with token
$repoUrlWithAuth = "https://induridharani-19:$token@github.com/induridharani-19/SmartCrop.git"

Write-Host "Pushing all files to induridharani-19...`n" -ForegroundColor Cyan

git push $repoUrlWithAuth main --force

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║        ✅ PUSH SUCCESSFUL!                                      ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green
    
    Write-Host "✅ All files pushed to:" -ForegroundColor Green
    Write-Host "   https://github.com/induridharani-19/SmartCrop`n" -ForegroundColor Cyan
    
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "NEXT STEP: Enable GitHub Pages" -ForegroundColor Yellow
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan
    
    Write-Host "Opening GitHub Pages settings...`n" -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    Start-Process "https://github.com/induridharani-19/SmartCrop/settings/pages"
    
    Write-Host "In the Pages settings:" -ForegroundColor Green
    Write-Host "  1. Source: 'Deploy from a branch'" -ForegroundColor White
    Write-Host "  2. Branch: 'main'" -ForegroundColor White
    Write-Host "  3. Folder: '/ (root)'" -ForegroundColor White
    Write-Host "  4. Click SAVE button`n" -ForegroundColor White
    
    Read-Host "Press ENTER after you've clicked SAVE"
    
    Write-Host "`n╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║           🎉 DEPLOYMENT COMPLETE!                              ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green
    
    Write-Host "Your website will be live at:" -ForegroundColor Cyan
    Write-Host "  https://induridharani-19.github.io/SmartCrop/`n" -ForegroundColor White -BackgroundColor Blue
    
    Write-Host "Wait 2-3 minutes for GitHub Pages to publish, then visit the URL above!`n" -ForegroundColor Yellow
    
} else {
    Write-Host "`n❌ Push failed!`n" -ForegroundColor Red
    Write-Host "Possible issues:" -ForegroundColor Yellow
    Write-Host "  • Token is incorrect or expired" -ForegroundColor White
    Write-Host "  • Token doesn't have 'repo' scope" -ForegroundColor White
    Write-Host "  • Network connection issue`n" -ForegroundColor White
}

Read-Host "Press any key to exit"
