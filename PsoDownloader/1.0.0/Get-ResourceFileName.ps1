function Get-ResourceFileName
{
  param
  (
    [Parameter(Mandatory,ValueFromPipeline)]
    [string]
    $url
  )
  
  begin
  {
    # get the download tool for the current operating system
    # if the tool isn't present yet, its latest release will be downloaded from github
    $executable = Get-BinaryDownloadCommand
  } 
  process
  {
    # get file name of file we are about to download:
    $result = & $executable -f best --get-filename $url 2>$null 
    Assert-NotNull -String $result -Message "No downloadable file found." |
    Test-Executable  
  }
}