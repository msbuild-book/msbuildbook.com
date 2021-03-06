﻿function Get-ScriptDirectory
{
	$Invocation = (Get-Variable MyInvocation -Scope 1).Value
	Split-Path $Invocation.MyCommand.Path
}

$scriptPath = Get-ScriptDirectory
$ajaxMinPath = (join-path $scriptPath "tools\ajaxmin\AjaxMin.exe")

if((Test-Path $ajaxMinPath)){
    Set-Alias ajaxmin $ajaxMinPath

    ajaxmin -CSS .\WebSite\content\msb.css -out .\WebSite\content\msb.min.css

    ajaxmin -JS .\WebSite\scripts\allScripts.js -out .\WebSite\scripts\allScripts.min.js
}
else {
    throw "Ajax Min not found at [$ajaxMinPath]"
}