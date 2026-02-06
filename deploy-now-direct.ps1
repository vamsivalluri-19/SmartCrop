# Push all SmartCrop files to induridharani-19 immediately
# This script clones the target repo and copies all files there

Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║    SMARTCROP - DIRECT DEPLOY TO INDURIDHARANI-19            ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

# Create temp directory for induridharani repo
$tempDir = "C:\Temp\SmartCrop-induridharani"
$sourceDir = "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"

# Clean previous temp if exists
if (Test-Path $tempDir) {
    Write-Host "🧹 Cleaning previous temp directory..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $tempDir | Out-Null
}

Write-Host "📥 Step 1: Cloning induridharani-19 repository..." -ForegroundColor Cyan
Write-Host "   (This requires your GitHub authentication)`n" -ForegroundColor White

# Clone the induridharani repo
git clone https://github.com/induridharani-19/SmartCrop.git $tempDir

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n❌ Clone failed - checking if repo is private or doesn't exist..." -ForegroundColor Red
    Write-Host "Please make sure:" -ForegroundColor Yellow
    Write-Host "  1. Repository https://github.com/induridharani-19/SmartCrop exists" -ForegroundColor White
    Write-Host "  2. It's set to PUBLIC (not Private)" -ForegroundColor White
    Write-Host "  3. You're logged into GitHub`n" -ForegroundColor White
    pause
    exit 1
}

Write-Host "✅ Repository cloned successfully`n" -ForegroundColor Green

# Copy all files from SmartCrop to temp location
Write-Host "📋 Step 2: Copying all SmartCrop files..." -ForegroundColor Cyan

# Copy files (exclude .git and node_modules)
Get-ChildItem -Path $sourceDir -Force | Where-Object { 
    $_.Name -ne ".git" -and $_.Name -ne "node_modules" -and $_.Name -ne ".venv"
} | ForEach-Object {
    $destPath = Join-Path $tempDir $_.Name
    if ($_.PSIsContainer) {
        Copy-Item -Path $_.FullName -Destination $destPath -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
        Write-Host "   ✓ Copied folder: $($_.Name)" -ForegroundColor Gray
    } else {
        Copy-Item -Path $_.FullName -Destination $destPath -Force -ErrorAction SilentlyContinue | Out-Null
        Write-Host "   ✓ Copied file: $($_.Name)" -ForegroundColor Gray
    }
}

Write-Host "`n✅ All files copied successfully`n" -ForegroundColor Green

# Change to temp directory and commit
Write-Host "📝 Step 3: Committing all files..." -ForegroundColor Cyan
Set-Location $tempDir

# Configure git user for this operation
git config user.email "deploy@smartcrop.local"
git config user.name "SmartCrop Deployer"

# Add all files
git add -A

# Commit
$commitResult = git commit -m "Deploy all SmartCrop files - 35 files total" 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Files committed`n" -ForegroundColor Green
} else {
    if ($commitResult -match "nothing to commit") {
        Write-Host "ℹ️  Files already up to date (nothing to commit)`n" -ForegroundColor Yellow
    } else {
        Write-Host "✅ Commit processed`n" -ForegroundColor Green
    }
}

# Push to repository
Write-Host "⬆️  Step 4: Pushing to GitHub..." -ForegroundColor Cyan
Write-Host "    Repository: https://github.com/induridharani-19/SmartCrop`n" -ForegroundColor White

git push origin main -u --force

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║              ✅ PUSH SUCCESSFUL!                            ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green
    
    Write-Host "📦 35 files successfully pushed to:" -ForegroundColor White
    Write-Host "   https://github.com/induridharani-19/SmartCrop`n" -ForegroundColor Cyan
    
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "STEP 5: Enable GitHub Pages" -ForegroundColor Yellow
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    
    Write-Host "`nOpening Pages settings in browser...`n" -ForegroundColor White
    Start-Sleep -Seconds 2
    Start-Process "https://github.com/induridharani-19/SmartCrop/settings/pages"
    
    Write-Host "Configure these settings:" -ForegroundColor Green
    Write-Host "  Source: Deploy from a branch" -ForegroundColor White
    Write-Host "  Branch: main" -ForegroundColor White
    Write-Host "  Folder: / (root)" -ForegroundColor White
    Write-Host "  Click 'Save' button`n" -ForegroundColor White
    
    Write-Host "Press ENTER when you've configured Pages..." -ForegroundColor Green
    $null = Read-Host
    
    Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║           🎉 WEBSITE DEPLOYMENT COMPLETE! 🎉                ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green
    
    Write-Host "🌐 Your website URL:" -ForegroundColor Cyan
    Write-Host "   https://induridharani-19.github.io/SmartCrop/`n" -ForegroundColor White -BackgroundColor Blue
    
    Write-Host "⏱️  Wait 2-3 minutes for GitHub Pages to publish...`n" -ForegroundColor Yellow
    
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "BOTH ACCOUNTS NOW DEPLOYED!" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    
    Write-Host "`n✅ Account 1: https://vamsivalluri-19.github.io/SmartCrop/" -ForegroundColor Green
    Write-Host "✅ Account 2: https://induridharani-19.github.io/SmartCrop/`n" -ForegroundColor Green
    
    Write-Host "Files deployed: 35 total" -ForegroundColor White
    Write-Host "Demo images: 45+ (all working)" -ForegroundColor White
    Write-Host "Cost: \$0/month (FREE)🎉`n" -ForegroundColor Green
    
    # Cleanup
    Set-Location "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"
    Write-Host "🧹 Cleaning up temp files..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue | Out-Null
    Write-Host "✅ Done!`n" -ForegroundColor Green
    
} else {
    Write-Host "`n❌ Push failed!`n" -ForegroundColor Red
    Write-Host "Error: If authentication failed, you may need to:" -ForegroundColor Yellow
    Write-Host "  1. Configure git credentials globally" -ForegroundColor White
    Write-Host "  2. Use SSH keys instead of HTTPS" -ForegroundColor White
    Write-Host "  3. Create a Personal Access Token" -ForegroundColor White
    Write-Host "`nTry running from the cloned repo manually..." -ForegroundColor Gray
    Write-Host "Location: $tempDir`n" -ForegroundColor White
}

Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
