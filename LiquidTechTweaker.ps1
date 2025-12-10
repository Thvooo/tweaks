# ===========================================
#        LIQUID TECH PC Tweaker v1.5
#      Clean • Safe • Gaming • Internet • FPS
# ===========================================

$LTVersion = "1.5"   
$LTRepoURL = "https://raw.githubusercontent.com/YOURNAME/YOURREPO/main/LiquidTechTweaker.ps1"

# ------------------------------
#      ASCII LOGO (Liquid)
# ------------------------------
$LTLogo = @"
___________.__                         __                         __            
\__    ___/|  |_____  ______  ______ _/  |___  _  __ ____ _____  |  | __  ______
  |    |   |  |  \  \/ /  _ \/  ___/ \   __\ \/ \/ // __ \\__  \ |  |/ / /  ___/
  |    |   |   Y  \   (  <_> )___ \   |  |  \     /\  ___/ / __ \|    <  \___ \ 
  |____|   |___|  /\_/ \____/____  >  |__|   \/\_/  \___  >____  /__|_ \/____  >
                \/               \/                     \/     \/     \/     \/ 
                          T H V O  T W E A K E S
"@

function LT-Header {
    Clear-Host
    Write-Host $LTLogo -ForegroundColor Cyan
    Write-Host "Version: $LTVersion" -ForegroundColor DarkGray
    Write-Host ""
}

# ------------------------------
#       Auto Updater
# ------------------------------
function LT-Update {
    LT-Header
    Write-Host "Checking for updates..." -ForegroundColor Cyan
    try {
        $remote = (iwr -useb $LTRepoURL).Content
        if ($remote -match '\$LTVersion = "(.+?)"') { $remoteVersion = $matches[1] }

        if ($remoteVersion -gt $LTVersion) {
            Write-Host "New version available: $remoteVersion" -ForegroundColor Green
            Write-Host "Updating..." -ForegroundColor Yellow
            $scriptPath = $MyInvocation.MyCommand.Source
            iwr -useb $LTRepoURL | Out-File $scriptPath -Force
            Write-Host "Updated successfully! Restarting..." -ForegroundColor Green
            Start-Sleep 2
            powershell -ExecutionPolicy Bypass -File $scriptPath
            exit
        } else { Write-Host "You are on the latest version." -ForegroundColor Green }
    } catch { Write-Host "Update check failed." -ForegroundColor Red }
    Pause
}

# ------------------------------
#           Menu
# ------------------------------
function LT-Menu {
    LT-Header
    Write-Host "1) System Info"
    Write-Host "2) Clean Temporary Files"
    Write-Host "3) Safe Startup Optimizer"
    Write-Host "4) Toggle Dark/Light Mode"
    Write-Host "5) Basic Network Reset"
    Write-Host "6) Create Restore Point"
    Write-Host "7) Safe Windows Services Optimization"
    Write-Host "8) Internet Optimizer"
    Write-Host "9) Repair Windows Components"
    Write-Host "10) Debloater (Safe)"
    Write-Host "11) FPS Booster (Advanced)"
    Write-Host "12) Latency Optimizer"
    Write-Host "13) DNS Changer"
    Write-Host "14) Check for Updates"
    Write-Host "15) Exit"
    Write-Host "16) Extra Debloater + Safe Tweaks"
    Write-Host ""
}

# ------------------------------
#      System Tools
# ------------------------------
function LT-SystemInfo {
    LT-Header
    Write-Host "System Information:`n" -ForegroundColor Yellow
    Get-ComputerInfo | Select-Object OSName, OSVersion, CsManufacturer, CsModel, CsSystemType, CsRAM, CsNumberOfLogicalProcessors
    Pause
}

function LT-CleanTemp {
    LT-Header
    Write-Host "Cleaning temporary files..." -ForegroundColor Yellow
    $paths = @("$env:TEMP\*", "$env:WINDIR\Temp\*")
    foreach ($p in $paths) { Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue }
    Write-Host "Temp files cleaned." -ForegroundColor Green
    Pause
}

function LT-StartupOptimizer {
    LT-Header
    Write-Host "Startup Programs:" -ForegroundColor Yellow
    Get-CimInstance Win32_StartupCommand | Select-Object Name, Command | Format-Table -AutoSize
    Pause
}

function LT-ToggleTheme {
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    $current = (Get-ItemProperty -Path $regPath -Name AppsUseLightTheme).AppsUseLightTheme
    Set-ItemProperty -Path $regPath -Name AppsUseLightTheme -Value ($current -bxor 1)
    Write-Host "Theme toggled." -ForegroundColor Green
    Pause
}

function LT-NetworkReset {
    LT-Header
    ipconfig /flushdns | Out-Null
    ipconfig /release | Out-Null
    ipconfig /renew | Out-Null
    Write-Host "Network reset complete." -ForegroundColor Green
    Pause
}

function LT-RestorePoint {
    LT-Header
    Checkpoint-Computer -Description "LiquidTech Restore Point" -RestorePointType "MODIFY_SETTINGS"
    Write-Host "Restore Point created." -ForegroundColor Green
    Pause
}

function LT-ServiceOptimize {
    LT-Header
    $services = @("DiagTrack","dmwappushservice")
    foreach ($svc in $services) { if (Get-Service -Name $svc -ErrorAction SilentlyContinue) { Set-Service -Name $svc -StartupType Disabled } }
    Write-Host "Safe service tweaks applied." -ForegroundColor Green
    Pause
}

# ------------------------------
#        Internet Optimizer
# ------------------------------
function LT-InternetOptimize {
    LT-Header
    ipconfig /flushdns | Out-Null
    netsh winsock reset | Out-Null
    netsh int ip reset | Out-Null
    netsh advfirewall reset | Out-Null
    netsh branchcache reset | Out-Null
    netsh interface tcp set global autotuninglevel=normal | Out-Null
    netsh interface tcp set global congestionprovider=ctcp | Out-Null
    Write-Host "Internet optimization complete." -ForegroundColor Green
    Pause
}

# ------------------------------
#         Repair Tools
# ------------------------------
function LT-RepairTools {
    LT-Header
    dism /online /cleanup-image /restoreHealth
    sfc /scannow
    Write-Host "Repairs complete." -ForegroundColor Green
    Pause
}

# ------------------------------
#       Debloater (SAFE)
# ------------------------------
function LT-Debloat {
    LT-Header
    $bloat = @("Microsoft.3DBuilder","Microsoft.XboxApp","Microsoft.XboxGamingOverlay","Microsoft.People","Microsoft.MinecraftUWP")
    foreach ($app in $bloat) { Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue }
    Write-Host "Debloating complete." -ForegroundColor Green
    Pause
}

# ------------------------------
#       FPS Booster (Mode B)
# ------------------------------
function LT-FPSBoost {
    LT-Header
    Write-Host "Applying FPS optimizations (Mode B)..." -ForegroundColor Yellow

    # Power & CPU
    powercfg -setactive SCHEME_MAX | Out-Null

    # GPU Scheduling
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name HwSchMode -Value 2 -Force

    # Game Mode
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1 -Force

    # VRR / Low Latency (NVIDIA registry-friendly)
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\UserGpuPreferences" -Name "GpuPreference" -Value 1 -Force

    # Memory / Standby flush
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Runtime.InteropServices")
    $empty = New-Object byte[] 1
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()

    # Full CPU Power for gaming
    powercfg -setacvalueindex SCHEME_MAX SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg -setdcvalueindex SCHEME_MAX SUB_PROCESSOR PROCTHROTTLEMAX 100

    Write-Host "FPS boost applied." -ForegroundColor Green
    Pause
}

# ------------------------------
#       Latency Optimizer
# ------------------------------
function LT-Latency {
    LT-Header
    netsh int tcp set global autotuninglevel=normal | Out-Null
    netsh int tcp set global ecncapability=disabled | Out-Null
    netsh int tcp set global rss=enabled | Out-Null

    # Mouse & Keyboard tweaks
    $mouseReg = "HKCU:\Control Panel\Mouse"
    Set-ItemProperty -Path $mouseReg -Name "MouseSensitivity" -Value 10
    Set-ItemProperty -Path $mouseReg -Name "MouseSpeed" -Value 1
    Set-ItemProperty -Path $mouseReg -Name "MouseThreshold1" -Value 0
    Set-ItemProperty -Path $mouseReg -Name "MouseThreshold2" -Value 0

    $keyboardReg = "HKCU:\Control Panel\Keyboard"
    Set-ItemProperty -Path $keyboardReg -Name "KeyboardDelay" -Value 0
    Set-ItemProperty -Path $keyboardReg -Name "KeyboardSpeed" -Value 31

    Write-Host "Latency optimized." -ForegroundColor Green
    Pause
}

# ------------------------------
#       DNS Changer Module
# ------------------------------
function LT-DNSChanger {
    LT-Header
    Write-Host "Choose DNS Provider:`n"
    Write-Host "1) Cloudflare (1.1.1.1)"
    Write-Host "2) Google (8.8.8.8)"
    Write-Host "3) Quad9 (9.9.9.9)"
    Write-Host "4) OpenDNS (208.67.222.222)"
    Write-Host "5) Reset to ISP DNS"
    $choice = Read-Host "Select"
    $adapter = (Get-NetAdapter | Where-Object Status -eq "Up" | Select-Object -First 1).Name
    switch($choice){
        "1" { Set-DnsClientServerAddress -InterfaceAlias $adapter -ServerAddresses 1.1.1.1 }
        "2" { Set-DnsClientServerAddress -InterfaceAlias $adapter -ServerAddresses 8.8.8.8 }
        "3" { Set-DnsClientServerAddress -InterfaceAlias $adapter -ServerAddresses 9.9.9.9 }
        "4" { Set-DnsClientServerAddress -InterfaceAlias $adapter -ServerAddresses 208.67.222.222 }
        "5" { Set-DnsClientServerAddress -InterfaceAlias $adapter -ResetServerAddresses }
        default { Write-Host "Invalid option." -ForegroundColor Red }
    }
    Write-Host "DNS Updated." -ForegroundColor Green
    Pause
}

# ------------------------------
#       Extra Debloater + Safe Tweaks
# ------------------------------
function LT-ExtraDebloat {
    LT-Header
    Write-Host "Applying extra safe debloat and tweaks..." -ForegroundColor Yellow

    # Extra debloat
    $extraBloat = @(
        "Microsoft.ZuneMusic","Microsoft.ZuneVideo","Microsoft.SkypeApp","Microsoft.GetHelp",
        "Microsoft.Getstarted","Microsoft.Microsoft3DViewer","Microsoft.WindowsAlarms","Microsoft.WindowsCalculator",
        "Microsoft.WindowsCamera","Microsoft.WindowsMaps","Microsoft.WindowsSoundRecorder",
        "Microsoft.WindowsFeedbackHub","Microsoft.MSPaint","Microsoft.Office.OneNote","Microsoft.WindowsPhotos",
        "Microsoft.MicrosoftSolitaireCollection"
    )
    foreach ($app in $extraBloat) { Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue }

    # Disable Windows tips
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0

    # Disable UI animations
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 100
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0

    # Disable safe scheduled tasks
    $tasks = @(
        "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
        "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask",
        "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    )
    foreach ($task in $tasks) { 
        if (Get-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue) { Disable-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue }
    }

    # Disable transparency
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0

    # Disable startup delay
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -Type DWord

    Write-Host "Extra debloat & tweaks applied safely." -ForegroundColor Green
    Pause
}

# ------------------------------
#           MAIN LOOP
# ------------------------------
do {
    LT-Menu
    $choice = Read-Host "Select an option"
    switch ($choice) {
        "1" { LT-SystemInfo }
        "2" { LT-CleanTemp }
        "3" { LT-StartupOptimizer }
        "4" { LT-ToggleTheme }
        "5" { LT-NetworkReset }
        "6" { LT-RestorePoint }
        "7" { LT-ServiceOptimize }
        "8" { LT-InternetOptimize }
        "9" { LT-RepairTools }
        "10" { LT-Debloat }
        "11" { LT-FPSBoost }
        "12" { LT-Latency }
        "13" { LT-DNSChanger }
        "14" { LT-Update }
        "15" { Write-Host "Exiting THVO Tweaker......" -ForegroundColor cyan }
        "16" { LT-ExtraDebloat }
        default { Write-Host "Invalid selection." -ForegroundColor Red }
    }
} while ($choice -ne 15)
