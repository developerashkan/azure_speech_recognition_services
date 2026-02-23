$ErrorActionPreference = 'Stop'

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
Set-Location $repoRoot

$dartFiles = git ls-files '*.dart'
if (-not $dartFiles) {
  Write-Host 'No Dart files found to format.'
  exit 0
}

# `git ls-files` returns relative paths, which keeps this safe from generated
# build output (for example, Android Gradle transform directories).
& dart format @dartFiles
