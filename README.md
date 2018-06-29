# Remove-Obsolete-Nuget-Cache
Remove Nuget Cache by PowerShell
刪除過時的 Nuget packages (Windoews)
內容修改自https://gist.github.com/thoemmi/c76f1a5533fa86e631b2ed9bbc43c412
 參考微軟Nuget Clean 路徑與參數說明:
 https://docs.microsoft.com/zh-tw/nuget/consume-packages/managing-the-global-packages-and-cache-folders
 因為不想一次刪除所有緩存，所以採用刪除老舊的Nuget packages
 
 Feature:
 1.增加路徑.net sdk 在dotnet restore 時產生的cache 
 2.修改掃描方式為最近修改日期，更準確找出過時Nuget packages
 
 使用方式:
 PS >.\Clear-NuGetCache.ps1 -CutOffDays 90 -WhatIf
 參數說明: 最近一次修改Nuget packages目錄日期大於90天則刪，可自行修改
 
 
