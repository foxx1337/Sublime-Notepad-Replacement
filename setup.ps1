Param (
    [parameter(HelpMessage="Full path to Sublime Text (sublime_text.exe)")]
    [alias("s", "st", "subl", "sublime")]
    [String]
    $SublimePath = $(Join-Path (Get-Location).Path "sublime_text.exe"),
    
    [parameter(HelpMessage="Full path to the Sublime Notepad replacement launcher ")]
    [alias("l", "launcher")]
    [String]
    $LauncherPath = $(Join-Path (Get-Location).Path "SublimeLauncher.exe"),

    [Switch]
    [alias("r", "rm", "restore")]
    $RestoreNotepad
)

if ($RestoreNotepad)
{
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" -ErrorAction SilentlyContinue
}
else
{
    $LauncherPath = (Resolve-Path $LauncherPath)
    $SublimePath = (Resolve-Path $SublimePath)

    if (!(Test-Path $LauncherPath -PathType Leaf))
    {
        Write-Output "Cannot find the SublimeLauncher.exe path at ""$LauncherPath"". Specify it with the -l flag."
        Exit 1
    }

    if (!(Test-Path $SublimePath -PathType Leaf))
    {
        Write-Output "Cannot find the sublime_text.exe path at ""$SublimePath"". Specify it with the -s flag."
        Exit 1
    }

    New-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" -ErrorAction SilentlyContinue
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" -Name "Debugger" -Value """$LauncherPath"" -s ""$SublimePath"" -z" -ErrorAction SilentlyContinue
}
