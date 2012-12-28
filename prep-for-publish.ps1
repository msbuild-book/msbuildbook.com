


# To be continued

function Get-ScriptDirectory
{
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}

function CompressCss 
{
    param($packerPath,$scriptDir)
    if(!(Test-Path $packerPath)){
        throw ("packer.exe not found at $packerPath")
    }


    $command = ("'{0}' -o " -f $packerPath)

}

$scriptDir = Get-ScriptDirectory 
$toolsDir = Join-Path -Path $scriptDir -ChildPath tools
$packerPath = Join-Path -Path $toolsDir -ChildPath packer\packer.exe

"Scripts directory $scriptDir" | Write-Host