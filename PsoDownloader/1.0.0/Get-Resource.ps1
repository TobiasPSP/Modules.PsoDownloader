function Get-Resource
{

  param
  (
    [Parameter(Mandatory,ValueFromPipeline)]
    [string]
    $Url,
    
    [Parameter(Mandatory)]
    [string]
    $FolderPath,
    
    [string]
    $Message = 'Download',
    
    [Parameter(Mandatory)]
    [ValidateRange(1,100)]
    [int]
    $ThrottleLimit
  )
  
  begin
  {
    # get the download tool for the current operating system
    # if the tool isn't present yet, its latest release will be downloaded from github
    $executable = Get-BinaryDownloadCommand
    Push-Location
    Set-Location -Path $FolderPath
    [Environment]::CurrentDirectory = $FolderPath
    
  } 
  process
  {
    # download file to current folder:
    $percent = 0
    # start downloading and pipe all output streams (including errors)
    # the download always goes to the filesystem. The piped streams are messages
    # and progress indicators such as the current download percentage:
    $null = & $executable --concurrent-fragments $ThrottleLimit $url *>&1 | 
    # eliminate null values
    Where-Object { ![string]::IsNullOrEmpty($_) } | 
    # process each message emitted by the tool:
    ForEach-Object { 
      # extract percentage from status text:
      if ($_-match '(\d{1,2}\.\d)%')
      {
        # always use maximum value seen to fix multithreading effects:
        $percent = [Math]::Max([double]$matches[1], $percent)
      }
      # show the current message in a progress bar and report the current progress percentage (if available):
      Write-Progress -Activity $Message -Status $_ -PercentComplete $percent
    }
  }
  end
  {
    Pop-Location
  }

}