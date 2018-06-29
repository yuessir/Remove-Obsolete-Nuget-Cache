[CmdletBinding(SupportsShouldProcess=$True)]
Param(
   [int]$CutoffDays =90
)

$cutoffDate = (Get-Date).AddDays(-$CutoffDays)

# get path to cached NuGet packages ("%USERPROFILE$\.nuget\packages")  && ref:https://docs.microsoft.com/zh-tw/dotnet/core/build/distribution-packaging
$nugetCachePath = Join-Path "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile))" ".nuget\packages"
$nugetSDKCachePath = Join-Path "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::ProgramFiles))" "dotnet\sdk\NuGetFallbackFolder"

# get all package versions
$packages = gci -Path $nugetCachePath | gci
$packagesSdkRestore = gci -Path $nugetSDKCachePath | gci

# get only those folders which weren't accessed since $cutoffDate, and also get their lengths
$oldPackages = $packages+ $packagesSdkRestore |
  ? { $_.LastWriteTimeUtc -le $cutoffDate } | 
  Sort-Object -Property LastWriteTime | 
  select Fullname,LastWriteTime,@{Name="Length";Expression={ (gci $_.Fullname -Recurse -Force | Measure-Object -Property Length -Sum).Sum }}

# delete those folder  
 $oldPackages | select -ExpandProperty Fullname | Remove-Item -Recurse

# output freed bytes
"{0:n2} Mb freed" -f (($oldPackages | Measure-Object -Property Length -Sum).Sum / 1Mb)

