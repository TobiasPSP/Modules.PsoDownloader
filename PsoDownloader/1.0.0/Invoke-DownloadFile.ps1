function Invoke-DownloadFile
{
  [Alias('download')]
  param
  (
    # URL of resource to download. Can be static image, video or streaming media
    # if no URL is specified, clipboard content is used instead
    [string]
    $Url = (Get-Clipboard),

    # local path to store downloaded media
    # if no path is specified, on Windows the official user download folder is used
    # if undefined on other OS, the default is a folder "Downloads", located in the temp folder
    [string]
    [ValidateNotNullOrEmpty()]
    $FolderPath = (Get-SystemFolderPathForDownload),
    
    # number of parallel threads to download fragments. Higher number = higher speed
    # Experiment with this setting. Some downloads may not support parallel downloading.
    # If download speed exceeds limits, some sites may throttle the download speed
    # each thread consumes resources so a value of 50 is a realistic maximum.
    [int]
    [ValidateRange(1,100)]
    $ThrottleLimit = 50,
    
    # opens the downloaded media in the default app
    [switch]
    $OpenPlayer,
    
    # opens Windows Explorer and selects the downloaded media file
    # this is platform-specific and does not work outside Windows
    [switch]
    $ShowInExplorer
  )
  
  # do we have a valid url to download?
  # if so, get the local filename for this download:
  $filename = $url | Test-Url -Message "Invoke-DownloadFile: no valid url submitted: $url" | Get-ResourceFileName | Assert-NotNull -Message 'No downloadable content.'
  
  # make sure local destination path exists
  $FolderPath | Assert-Exists 
  
  # construct the absolute path for the downloaded local file
  $filePath = Join-Path -Path $FolderPath -ChildPath $fileName 
  
  # download the resource into the specified local folder:
  Get-Resource -Url $url -FolderPath $FolderPath -Message $filename -ThrottleLimit $ThrottleLimit 
  
  # now the file is downloaded. Process the extra switches:
  
  # open downloaded media file in default app:
  if ($OpenPlayer)
  {
    & $filePath
  }
  
  # open Windows Explorer and select the downloaded media file (Windows only):
  if ($ShowInExplorer)
  {
    explorer /select,$filePath
  }
  
  # return the absolute path name of the downloaded file:
  return $filePath
}