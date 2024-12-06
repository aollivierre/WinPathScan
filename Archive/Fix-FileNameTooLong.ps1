# Tag: EnableLongPathsGit

# Ensure the script is running with administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Please run this script as an Administrator."
    exit
}

# Enable long path support in Git
try {
    git config --global core.longPaths true
    Write-Host "Git is now configured to support long paths."
} catch {
    Write-Error "Failed to configure Git: $_"
}
