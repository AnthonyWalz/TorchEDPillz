#Edit to where you want the logfile to go
$Logfile = "C:\Users\Administrator\Desktop\Logs.log"

Function LogWrite
{
   Param ([string]$logstring)
   $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
   $logline = "$Stamp $logstring"
   Add-content $Logfile -value $logline
   Write-Host $logline
   Write-Host " "
}
$text = @"

  _______             _       ______ _____    _____ _ _ _     
 |__   __|           | |     |  ____|  __ \  |  __ (_) | |    
    | | ___  _ __ ___| |__   | |__  | |  | | | |__) || | |____
    | |/ _ \| '__/ __| '_ \  |  __| | |  | | |  ___/ | | |_  /
    | | (_) | | | (__| | | | | |____| |__| | | |   | | | |/ / 
    |_|\___/|_|  \___|_| |_| |______|_____/  |_|   |_|_|_/___|
    Author: Princess Kenny
    Special Thanks: GarretSidzaka

    Do you sometimes have difficulty keeping your torch up?
    I know it can be a bit embarrassing, but no more.
    Now just add your torch paths to the script and let
    Torch ED Pillz checks every 30 seconds if it's still
    up if not it will start it again

    BTW Torch ED Pillz is running right now

"@ 
Write-Host $text
while($true){
    $data = @(
        #Add your paths here for multiple and new lines like this
        #[pscustomobject]@{path="C:\Users\Administrator\Desktop\SE server 1\Torch.Server.exe";alive=0}
        #[pscustomobject]@{path="C:\Users\Administrator\Desktop\SE server 2\Torch.Server.exe";alive=0}

       [pscustomobject]@{path="C:\Users\Administrator\Desktop\SE server new\Torch.Server.exe";alive=0}
    )
    Get-Process | where {$_.mainWindowTitle} | ForEach {
        For($i = 0; $i -lt $data.length; $i++){
            If($_.Path -eq $data[$i].path){
                $data[$i].alive=1
            }
        }
    }
    For($i = 0; $i -lt $data.length; $i++){
        If($data[$i].alive -eq 0){
            LogWrite "Found Torch Crashed. Starting $($data[$i].path)"
            [System.Diagnostics.Process]::Start($data[$i].path)
        }
    }
    write-host "." -nonewline
    Start-Sleep -Seconds 30
}
