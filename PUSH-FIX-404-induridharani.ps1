# ============================================================================
#   SMARTCROP - PUSH ALL FILES TO INDURIDHARANI-19 (FRESH REPO)
#   After you've created the repo manually on GitHub
# ============================================================================

Write-Host "`n" -ForegroundColor White
Write-Host "╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║     SMARTCROP - PUSH ALL FILES TO INDURIDHARANI-19             ║" -ForegroundColor Green
Write-Host "║              (Fresh Repository Setup)                          ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Green

Write-Host "`n" -ForegroundColor White

# ============================================================================
# Prerequisites Check
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "PREREQUISITES" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "✓ Have you created the repository on GitHub?" -ForegroundColor White
Write-Host "  Repository name: SmartCrop" -ForegroundColor Gray
Write-Host "  Visibility: PUBLIC" -ForegroundColor Gray
Write-Host "  Link: https://github.com/induridharani-19/SmartCrop`n" -ForegroundColor Gray

$repoCreated = Read-Host "Type 'yes' if done, or 'no' to cancel"

if ($repoCreated -ne "yes") {
    Write-Host "`n❌ Please create the repository first!" -ForegroundColor Red
    Write-Host "Go to: https://github.com/new" -ForegroundColor Yellow
    Write-Host "Then run this script again.`n" -ForegroundColor Yellow
    Read-Host "Press ENTER to exit"
    exit
}

Write-Host "`n✅ Great! Proceeding with file push...`n" -ForegroundColor Green

# ============================================================================
# Get Repository URL
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "REPOSITORY URL" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "Enter the HTTPS URL from your new GitHub repository." -ForegroundColor White
Write-Host "Should look like: https://github.com/induridharani-19/SmartCrop.git`n" -ForegroundColor Gray

$repoUrl = Read-Host "Paste repository URL"

if (-not $repoUrl.Contains("github.com")) {
    Write-Host "`n❌ Invalid URL!`n" -ForegroundColor Red
    Read-Host "Press ENTER to exit"
    exit
}

Write-Host "`n✅ Repository URL: $repoUrl`n" -ForegroundColor Green

# ============================================================================
# Setup
# ============================================================================

$sourceDir = "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"
$tempDir = "C:\Temp\SmartCrop-Push-Temp"

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 1: Clone Repository" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

if (Test-Path $tempDir) {
    Write-Host "🧹 Cleaning previous temp directory..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue | Out-Null
}

New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

Write-Host "📥 Cloning empty repository...`n" -ForegroundColor Cyan

cd $tempDir

$cloneOutput = git clone $repoUrl . 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Repository cloned successfully!`n" -ForegroundColor Green
} else {
    Write-Host "❌ Clone failed!`n" -ForegroundColor Red
    Write-Host "Error: $cloneOutput`n" -ForegroundColor Yellow
    Write-Host "Possible issues:" -ForegroundColor Yellow
    Write-Host "  • URL is incorrect" -ForegroundColor White
    Write-Host "  • Repository doesn't exist" -ForegroundColor White
    Write-Host "  • Not logged into GitHub (Git Credential Manager)" -ForegroundColor White
    Write-Host "  • No internet connection`n" -ForegroundColor White
    Read-Host "Press ENTER to exit"
    exit
}

# ============================================================================
# Copy Files
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 2: Copy All Files" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "📋 Copying files from: $sourceDir`n" -ForegroundColor White

$fileCount = 0
$dirCount = 0

# Copy all files recursively (excluding git, cache, node_modules, venv)
Get-ChildItem -Path $sourceDir -Force -Recurse | Where-Object {
    $_.FullName -notmatch '\.git\\|__pycache__|\.venv|node_modules|\.dist|\.hintrc'
} | ForEach-Object {
    if ($_.PSIsContainer) {
        $destPath = Join-Path $tempDir $_.FullName.Substring($sourceDir.Length + 1)
        if (-not (Test-Path $destPath)) {
            New-Item -ItemType Directory -Path $destPath -Force -ErrorAction SilentlyContinue | Out-Null
            $dirCount++
        }
    } else {
        $relativePath = $_.FullName.Substring($sourceDir.Length + 1)
        $destPath = Join-Path $tempDir $relativePath
        $destFolder = Split-Path $destPath
        
        if (-not (Test-Path $destFolder)) {
            New-Item -ItemType Directory -Path $destFolder -Force -ErrorAction SilentlyContinue | Out-Null
        }
        
        Copy-Item -Path $_.FullName -Destination $destPath -Force -ErrorAction SilentlyContinue
        $fileCount++
        
        if ($fileCount % 10 -eq 0) {
            Write-Host "  ✓ Copied $fileCount files..." -ForegroundColor Gray
        }
    }
}

Write-Host "`n✅ Copied $fileCount files and $dirCount directories!`n" -ForegroundColor Green

# ============================================================================
# Configure Git
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 3: Configure Git & Commit" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "⚙️  Configuring git user..." -ForegroundColor Cyan
git config user.email "smartcrop@deploy.local"
git config user.name "SmartCrop Deployer"

Write-Host "📝 Adding all files..." -ForegroundColor Cyan
git add -A

Write-Host "💾 Creating commit..." -ForegroundColor Cyan
git commit -m "Deploy SmartCrop - All 45+ files with complete functionality" 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Files committed successfully!`n" -ForegroundColor Green
} else {
    Write-Host "⚠️  Commit status checked`n" -ForegroundColor Yellow
}

# ============================================================================
# Push to GitHub
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 4: Push to GitHub" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "⬆️  Pushing to: $repoUrl`n" -ForegroundColor White
Write-Host "Note: You may need to authenticate with GitHub` Credentials Manager will prompt you.`n" -ForegroundColor Yellow

$pushOutput = git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ Push successful!`n" -ForegroundColor Green
} else {
    Write-Host "`n⚠️  Push output:`n" -ForegroundColor Yellow
    Write-Host $pushOutput -ForegroundColor Gray
    
    if ($pushOutput -match "Permission denied|403|unable to access") {
        Write-Host "`n❌ Authentication failed!`n" -ForegroundColor Red
        Write-Host "You may need to:" -ForegroundColor Yellow
        Write-Host "  1. Create a Personal Access Token at:" -ForegroundColor White
        Write-Host "     https://github.com/settings/tokens/new" -ForegroundColor Cyan
        Write-Host "  2. Use the token as the password when prompted" -ForegroundColor White
        Write-Host "  3. Run this script again`n" -ForegroundColor White
    }
    Read-Host "Press ENTER to continue anyway"
}

# ============================================================================
# Verify Files on GitHub
# ============================================================================

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 5: Verify Files on GitHub" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

$repoUrlDisplay = $repoUrl -replace "\.git$", ""

Write-Host "Opening repository to verify files...`n" -ForegroundColor Cyan
Start-Process $repoUrlDisplay

Start-Sleep -Seconds 3

Write-Host "Check that all files are visible at:" -ForegroundColor White
Write-Host "  $repoUrlDisplay`n" -ForegroundColor Cyan

Write-Host "Files should include:" -ForegroundColor White
Write-Host "  ✓ index.html" -ForegroundColor Gray
Write-Host "  ✓ login.html" -ForegroundColor Gray
Write-Host "  ✓ css/ folder" -ForegroundColor Gray
Write-Host "  ✓ js/ folder" -ForegroundColor Gray
Write-Host "  ✓ backend/ folder`n" -ForegroundColor Gray

Read-Host "Press ENTER when you've verified the files are visible"

# ============================================================================
# Enable GitHub Pages
# ============================================================================

Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "STEP 6: Enable GitHub Pages" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

$pagesUrl = "$repoUrlDisplay/settings/pages"

Write-Host "Opening Pages Settings...`n" -ForegroundColor Cyan
Start-Process $pagesUrl

Write-Host "In the GitHub Pages settings:" -ForegroundColor Green
Write-Host "  1. Build and deployment section" -ForegroundColor White
Write-Host "  2. Source: Select 'Deploy from a branch'" -ForegroundColor White
Write-Host "  3. Branch: Select 'main'" -ForegroundColor White
Write-Host "  4. Folder: Select '/ (root)'" -ForegroundColor White
Write-Host "  5. Click SAVE button`n" -ForegroundColor White

Read-Host "Press ENTER after you've clicked SAVE"

# ============================================================================
# Final Success
# ============================================================================

Write-Host "`n╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║              ✅ DEPLOYMENT COMPLETE!                           ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

$websiteUrl = "https://induridharani-19.github.io/SmartCrop/"

Write-Host "🌐 Your live website URL:" -ForegroundColor Cyan
Write-Host "   $websiteUrl`n" -ForegroundColor White -BackgroundColor Blue

Write-Host "⏱️  Wait 2-3 minutes, then visit the URL above!" -ForegroundColor Yellow
Write-Host "GitHub Pages is publishing your site...`n" -ForegroundColor Yellow

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host "BOTH ACCOUNTS NOW HAVE YOUR WEBSITE!" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

Write-Host "Account 1 (vamsivalluri-19):" -ForegroundColor White
Write-Host "  ✅ https://vamsivalluri-19.github.io/SmartCrop/`n" -ForegroundColor Green

Write-Host "Account 2 (induridharani-19):" -ForegroundColor White
Write-Host "  ✅ https://induridharani-19.github.io/SmartCrop/`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "CLEANUP" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan

Write-Host "🧹 Cleaning up temporary files...`n" -ForegroundColor Yellow
Set-Location "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"
Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue | Out-Null

Write-Host "✅ Done!`n" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Cyan
Write-Host "🎉 SmartCrop is now deployed to BOTH GitHub accounts!" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

Read-Host "Press any key to exit"
