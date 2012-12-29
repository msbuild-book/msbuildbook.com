# To be continued

function Get-ScriptDirectory
{
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}

function CompressCss 
{
    param($packerPath, $cssFiles)
    if(!(Test-Path $packerPath)){
        throw ("packer.exe not found at $packerPath")
    }

    foreach($cssFile in $cssFiles){
        # call packer.exe on it
        # packer.exe -o msb.min.css -m cssmin msb.css

        if(!(Test-Path $cssFile)){
            "CSS file not found at: [$cssFile]" | Write-Error
            throw
        }

        $cssFileObj = Get-Item $cssFile
        $minFile = ('{0}\{1}.min.css' -f $cssFileObj.Directory.FullName, $cssFileObj.BaseName)
        $cmdArgs = (" -o '{0}' -m cssmin '{1}'" -f $minFile, $cssFileObj.FullName)

        "Command :[$packerPath $cmdArgs]" | Write-Host
        # Execute the command
        & $packerPath $cmdArgs

        "*******************************" | Write-Host -ForegroundColor Green
        # $cmd="C:\Data\personal\my-code\msbuildbook.com\tools\packer\packer.exe -o 'C:\Data\personal\my-code\msbuildbook.com\WebSite\Content\site.min.css' -m cssmin 'C:\Data\personal\my-code\msbuildbook.com\WebSite\Content\site.css'"
        

        throw "*****************************"


        # we need to fixup the .min file a bit
        # packer.exe has a bug dealing with CSS media queries. Replace 'and(' with 'and ('

#        (Get-Content $minFile) | 
#            Foreach-Object {$_ -replace "and(", "and ("} | 
#            Set-Content $minFile

    }    
}

$scriptDir = Get-ScriptDirectory 
$toolsDir = (Join-Path -Path $scriptDir -ChildPath 'tools')
$packerPath = (Join-Path -Path $toolsDir -ChildPath 'packer\packer.exe')
$siteRoot = (Join-Path $scriptDir 'WebSite')

$cssFiles = (Get-ChildItem -Path "$siteRoot\Content" -Filter *.css).FullName

"Scripts directory $scriptDir" | Write-Host
# "CSS files: $cssfiles" | Write-Host
CompressCss -packerPath $packerPath -cssFiles $cssFiles



