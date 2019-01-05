Param (
    [Parameter(
        HelpMessage="Full path to Sublime Text (sublime_text.exe)."
    )]
    [alias("s", "st", "subl", "sublime")]
    [ValidateScript({
        Test-Path -Path $_ -PathType Leaf
    })]
    [String]
    $SublimePath = $(Join-Path (Get-Location).Path "sublime_text.exe"),
    
    [Parameter(
        HelpMessage="Full path to the Sublime Notepad replacement launcher."
    )]
    [alias("l", "launcher")]
    [ValidateScript({
        Test-Path -Path $_ -PathType Leaf
    })]
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

    Write-Output "wtf got $LauncherPath and $SublimePath"

    New-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" -ErrorAction SilentlyContinue
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" -Name "Debugger" -Value """$LauncherPath"" -s ""$SublimePath"" -z" -ErrorAction SilentlyContinue
}
