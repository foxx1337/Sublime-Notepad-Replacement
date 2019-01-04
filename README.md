## Sublime Text Launcher

### Introduction
This small utility provides the means to replace Notepad.exe on Windows with Sublime (or Visual Studio Code).

More information about Sublime Text can be found on [the Sublime Text website](http://www.sublimetext.com/)

### Installation

* Download the archive and extract it
* In an administrative Powershell prompt (make sure you have `Set-ExecutionPolicy Unrestricted`) execute `setup.ps1`:

  ```powershell
  Set-ExecutionPolicy Unrestricted
  .\setup.ps1 -s "C:\Toolz\Sublime Text\sublime_text.exe" -l "C:\Toolz\Sublime-Notepad-Replacement\src\Sublime Launcher\Release\SublimeLauncher.exe"
  ```
  
Enjoy!

### Uninstallation

* To uninstall, in an administrative Powershell prompt:

  ```powershell
  .\setup.ps1 -r
  ```
