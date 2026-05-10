# Optional local run: appends a UTC line to .github/activity.log, commits, pushes.
# Override with ACTIVITY_GIT_NAME / ACTIVITY_GIT_EMAIL if needed.

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path $PSScriptRoot -Parent
Set-Location $repoRoot

$logPath = Join-Path (Join-Path $repoRoot ".github") "activity.log"
$line = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
Add-Content -Path $logPath -Value $line

$name = if ($env:ACTIVITY_GIT_NAME) { $env:ACTIVITY_GIT_NAME } else { "uzair-14" }
$email = if ($env:ACTIVITY_GIT_EMAIL) { $env:ACTIVITY_GIT_EMAIL } else { "uzairalikhannnn1996@gmail.com" }

git config user.name $name
git config user.email $email
git add .github/activity.log
$diff = git diff --staged --quiet 2>$null; if ($LASTEXITCODE -eq 0) { Write-Host "Nothing to commit."; exit 0 }
$d = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd")
git commit -m "chore: activity log $d"
git push
