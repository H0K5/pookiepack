$wd = $SCRIPT:MyInvocation.MyCommand.path | Split-Path -Parent
Import-Module $wd\pp-mod.psm1

function test-wpad($set,$unset){
    if ($set){
        set-wpad
        if ((Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad").wpadoverride -eq 1){
            Write-Host "WPAD SET PASS!"
        }
        else{
            Write-Host "WPAT SET FAIL!"
        }
    }
    elseif($unset){
        clear-wpad
        if ((Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad")){
            Write-Host "WPAD CLEAR PASS!"
        }
        elseif ((Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad").wpadoverride -eq 1){
            Write-Host "WPAD CLEAR FAIL!"
        }
    }    
}
test-wpad -set 1
test-wpad -unset 1