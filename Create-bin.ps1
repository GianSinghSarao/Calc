Write-Host 'This Script Will Create Binary Executable Files Of The Calculator App, For Use On Windows Systems.'
Write-Host '==> ' -ForegroundColor 'Blue' -NoNewLine
Write-Host 'Verifiying NPM Is Installed In The Path '
$a = 1
$NPM
if ($env:Path -like '*npm*') {
  Write-Host 'NPM Is Installed In The Path '
  $NPM = 'npm'
}
else {
  Write-Host 'Error: ' -ForegroundColor 'Red' -NoNewLine
  Write-Host 'NPM Isn''t In The Path!! '
  Write-Host 'NPM Is Required To Get This Apps'' Dependencies '`n
  Write-Host 'If NPM Is Installed, Maybe It Got Displaced From The Path'
  $temp = Read-Host -Prompt 'If So, Enter The Path To NPM. Or Leave It Blank To Exit'
  Write-Host ''
  if ($temp) {
    $NPM = $temp
  }
  elseif ($temp -like '') {
    Write-Host 'Exiting Script... '
    Exit
  }
}

while ($a) {
  Write-Host '==> ' -ForegroundColor 'Blue' -NoNewLine
  Write-Host 'Verifiying NPM Version => 6.0.0 '
  $temp = & $NPM -v
  if ($temp -like '6.0.*') {
    Write-Host 'NPM Version Is => 6.0.0 '
    Write-Host '==> ' -ForegroundColor 'Green' -NoNewLine
    Write-Host 'Installing Dev Dependencies '
    Write-Host '[Output From NPM] ' -ForegroundColor 'Yellow'
    & $NPM i -g electron-packager
    Write-Host '==> ' -ForegroundColor 'Green' -NoNewLine
    Write-Host 'Installing App Dependencies '
    Set-Location './src'
    Write-Host '[Output From NPM] ' -ForegroundColor 'Yellow'
    & $NPM i
    Write-Host '==> ' -ForegroundColor 'Green' -NoNewLine
    Write-Host 'Creating Binary Files For ' -NoNewLine
    Write-Host 'Calculator ' -ForegroundColor 'Green'
    Write-Host '[Output From Electron Packager] ' -ForegroundColor 'Yellow'
    & electron-packager . --arch="all" --asar --icon="icon.ico" --out="../bin/" --executableName="Calc" --win32metadata.FileDescription="A calculator with 29-functions for basic arithmetic, algebra, trigonometry and discrete math." --win32metadata.InternalName="Calc" --win32metadata.ProductName="Calculator" --overwrite
    Set-Location '../'
    break
  }
  else {
    Write-Host 'NPM Is Too Old! '
    $temp = Read-Host -prompt 'Update NPM? (y)/n'
    if ($temp -like 'y*' -or $temp -like '') {
      Write-Host 'Updating NPM. '
      Write-Host '[Output From NPM] ' -ForegroundColor 'Yellow'
      & $NPM i npm -g
      continue
    }
    else {
      Write-Host 'Exiting Script... '
      Exit
    }
  }
}