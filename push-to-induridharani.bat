@echo off
echo ========================================================
echo   SMARTCROP - PUSH ALL FILES TO INDURIDHARANI-19
echo ========================================================
echo.
echo This script will push all 31 files to your second account.
echo.
echo STEP 1: Login to GitHub
echo ----------------------------------------
echo Please login to GitHub as: induridharani-19
echo.
pause

echo.
echo STEP 2: Opening GitHub to generate Personal Access Token
echo ----------------------------------------
echo.
echo Follow these steps:
echo   1. Click "Generate new token" (classic)
echo   2. Name: SmartCrop Deployment
echo   3. Expiration: 90 days
echo   4. Check: [x] repo (Full control of repositories)
echo   5. Click "Generate token" at bottom
echo   6. COPY the token (starts with ghp_...)
echo.
start https://github.com/settings/tokens/new
pause

echo.
echo STEP 3: Push with Authentication
echo ----------------------------------------
echo.
set /p TOKEN="Paste your token here: "

echo.
echo Pushing all 31 files to induridharani-19...
echo.

cd /d "C:\Users\VAMSI VALLURI\OneDrive\Documents\SmartCrop"

git push https://%TOKEN%@github.com/induridharani-19/SmartCrop.git main --force

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================================
    echo   SUCCESS! All files pushed to induridharani-19
    echo ========================================================
    echo.
    echo Repository: https://github.com/induridharani-19/SmartCrop
    echo.
    echo STEP 4: Enable GitHub Pages
    echo ----------------------------------------
    echo Opening Pages settings...
    start https://github.com/induridharani-19/SmartCrop/settings/pages
    echo.
    echo Set these options:
    echo   Source: Deploy from a branch
    echo   Branch: main
    echo   Folder: / (root)
    echo   Click SAVE
    echo.
    echo Your website will be live at:
    echo https://induridharani-19.github.io/SmartCrop/
    echo.
    echo Wait 2-3 minutes for deployment.
    echo.
) else (
    echo.
    echo ERROR: Push failed. Please check:
    echo   1. Token is correct
    echo   2. Repository exists
    echo   3. Token has 'repo' permissions
    echo.
)

pause
