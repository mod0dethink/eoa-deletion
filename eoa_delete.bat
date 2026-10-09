@echo off
set "TARGET=%~1"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$t = $env:TARGET; if (-not $t) { try { $t = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path } catch {} }; if (-not $t) { $t = Join-Path $env:USERPROFILE 'Downloads' }; Write-Host ('Target: ' + $t); if (-not (Test-Path -LiteralPath $t)) { Write-Host 'Folder not found.'; exit }; Write-Host ''; $f = @(Get-ChildItem -LiteralPath $t -File | Where-Object { $_.Name -match '^eoa ?(\(\d+\))?\.html?$' }); if ($f.Count -eq 0) { Write-Host 'No eoa files found.'; exit }; $f | ForEach-Object { Write-Host ('  ' + $_.Name) }; Write-Host ''; Write-Host ('Found ' + $f.Count + ' file(s).'); $a = Read-Host 'Delete them? (y/n)'; if ($a -eq 'y') { $f | Remove-Item -Force; Write-Host 'Deleted.' } else { Write-Host 'Canceled.' }"

echo.
pause
