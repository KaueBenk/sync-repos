param(
    # Path to the parent directory containing the repositories
    [string]$ReposPath = ".."
)

$problemRepos = @()

function SendNotification {
    param (
        [string]$title,
        [string]$message,
        [string]$sound = "Default"
    )

    if (-not (Get-Module -ListAvailable -Name BurntToast)) {
        Write-Host "BurntToast module not found. Skipping notification." -ForegroundColor Yellow
        Write-Host 'Install it using "Install-Module -Name BurntToast"'
        return
    }
    
    New-BurntToastNotification -Text $title, $message -Sound $sound
}

Get-ChildItem -Directory $ReposPath | ForEach-Object {
    $repoName = $_.Name
    Write-Host "Processing repository: $repoName" -ForegroundColor Cyan
    Set-Location $_.FullName
    
    git pull
    git push
    
    $status = git status --porcelain
    
    if ($status) {
        $branchName = git branch --show-current
        $problemRepos += [PSCustomObject]@{
            Repository = $repoName
            Branch = $branchName
            Status = $status
        }
        Write-Host "Warning: Working tree is not clean!" -ForegroundColor Yellow
    } else {
        Write-Host "OK: Working tree is clean" -ForegroundColor Green
    }
    
    Write-Host ""
}

if ($problemRepos.Count -eq 0) {
    SendNotification -title "Repository Sync Status" -message "All repositories are clean."
    Write-Host "No problems found! All repositories are clean." -ForegroundColor Green
} else {
    SendNotification -title "Repository Sync Issues" -message "Found $($problemRepos.Count) repository(ies) with problems."
    Write-Host "============================================" -ForegroundColor Magenta
    Write-Host "PROBLEM REPORT" -ForegroundColor Magenta
    Write-Host "============================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "Found $($problemRepos.Count) repository(ies) with problems:" -ForegroundColor Yellow
    Write-Host ""
    
    foreach ($problem in $problemRepos) {
        Write-Host "Repository: $($problem.Repository)" -ForegroundColor Red
        Write-Host "Branch: $($problem.Branch)" -ForegroundColor Yellow
        Write-Host "Status:" -ForegroundColor Yellow
        $problem.Status | ForEach-Object { Write-Host "  $_" }
        Write-Host ""
    }
}
