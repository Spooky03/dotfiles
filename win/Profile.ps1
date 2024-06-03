<#
File to be copied to one of the following paths depending on preference
	Description					Path															Command to open
	Current user – Current host	$Home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1		$profile
	Current user – All hosts	$Home\Documents\PowerShell\Profile.ps1							$profile.CurrentUserAllHosts
	All Users – Current Host	$PSHOME\Microsoft.PowerShell_profile.ps1						$profile.AllUsersCurrentHost
	All Users – All Hosts		$PSHOME\Profile.ps1	$profile.AllUsersAllHosts
	
Settings.json should be placed in the following path to apply fonts 
and future additional console commands for Microsoft Terminal

C:\users\ckilby\AppData\Local\Packages\Microsft.WindowsTerminal_dlkfjadlkfj;\LocalState\settings.json
#>


$shell = $Host.UI.RawUI
$shell.WindowTitle = "PS"
$env:Path += ";C:\SourceCode\Snippets"

Set-Alias -Name l -Value dir
Set-Alias -Name cl -Value clear
Set-Alias -Name np -Value 'C:\Windows\notepad.exe'
Set-Alias -Name npp -Value 'C:\Program Files\Notepad++\notepad++.exe'

oh-my-posh.exe init powershell -c C:\Users\ckilby\AppData\Local\Programs\oh-my-posh\themes\cinnamon.omp.json | Invoke-Expression
	
