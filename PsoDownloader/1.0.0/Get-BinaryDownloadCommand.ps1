function Get-BinaryDownloadCommand
{
  param
  (
    # path to download the executable to
    # if omitted, temporary folder is used
    [string]
    [ValidateNotNullOrEmpty()]
    $Path = "$env:temp$env:tmpdir"
  )
    
  # tool is OS specific so lets figure out the correct tool name
  
  # add PS7 variables to older powershell versions:
  if ($PSVersionTable.PSVersion.Major -le 5) 
  { 
    $IsWindows = $true 
    $IsMacOs = $IsLinux = $false
  }
  
  # determine OS-specific tool executable name:
  $toolname = 
  if ($IsWindows) { 'yt-dlp_min.exe' }
  elseif ($IsMacOs) { 'yt-dlp_macos' }
  elseif ($IsLinux) { 'yt-dlp' }
  
  # already present?
  $filepath = Join-Path -Path $Path -ChildPath yt-dlp_min.exe
  $exists = Test-Path -Path $filepath
  if ($exists) { return $filepath }

  # no, let's download the latest release available (newest)
  
  # first, find out the latest release number from github:
  $info = Invoke-RestMethod -Uri https://github.com/yt-dlp/yt-dlp/releases/latest -Headers @{Accept='application/json'} -UseBasicParsing
  $release = $info.tag_name
    
  # second, construct the download path for the required OS-specific tool:
  $url = "https://github.com/yt-dlp/yt-dlp/releases/download/$release/$toolname"
  
  # third, download the file and unblock it (on Windows)
  # make sure TLS1.2 is supported (on older Windows systems it may not)
  #l[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -band  [Net.SecurityProtocolType]::Tls12
  Invoke-RestMethod -UseBasicParsing -Uri $url -OutFile $filepath
  if ($IsWindows) { Unblock-File -Path $filepath }
  
  # return the downloaded media file absolute path:
  return $filepath
}