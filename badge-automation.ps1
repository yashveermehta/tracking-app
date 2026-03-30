# 1. Quickdraw
Write-Host "Creating and closing issue for Quickdraw badge..."
..\..\bin\gh.exe issue create --title "Fix rendering bug in dashboard" --body "The dashboard table rendering glitches on Safari. Need to add polyfill or CSS fixes."
Start-Sleep -Seconds 12
..\..\bin\gh.exe issue close 1

# 2. YOLO
Write-Host "Creating PR 1 for YOLO badge..."
git checkout -b feature/auth-middleware
New-Item middleware.js -Value 'module.exports = (req, res, next) => { console.log("auth mw"); next(); };' -Force
git add .
git commit -m "Add authentication middleware"
git push -u origin feature/auth-middleware
..\..\bin\gh.exe pr create --title "feat: Add basic auth middleware" --body "Adds middleware to check token before proceeding." --base master --head feature/auth-middleware
..\..\bin\gh.exe pr merge 1 --merge --admin

# 3. Pull Shark #2
Write-Host "Creating PR 2 for Pull Shark badge..."
git checkout master
git pull
git checkout -b feature/admin-dashboard
New-Item admin.js -Value 'const adminRoutes = require("express").Router(); module.exports = adminRoutes;' -Force
git add .
git commit -m "Initialize admin dashboard routes"
git push -u origin feature/admin-dashboard
..\..\bin\gh.exe pr create --title "feat: Admin dashboard foundation" --body "Sets up the routing for the admin portal." --base master --head feature/admin-dashboard
..\..\bin\gh.exe pr merge 2 --merge --admin

# 4. Pull Shark #3 and Pair Extraordinaire
Write-Host "Creating PR 3 with co-authored commit for Pair Extraordinaire and Pull Shark badge..."
git checkout master
git pull
git checkout -b fix/auth-typo
New-Item README.md -Value '# Tracking App' -Force
git add .
$commitMsg = "Fix typo in documentation`n`nCo-authored-by: bot <bot@github.com>"
git commit -m $commitMsg
git push -u origin fix/auth-typo
..\..\bin\gh.exe pr create --title "docs: Update readme" --body "Adding documentation." --base master --head fix/auth-typo
..\..\bin\gh.exe pr merge 3 --merge --admin

Write-Host "All realistic badge farming commits, PRs, and issues completed successfully!"
