function Assert-Exists
{
  param
  (
    [Parameter(Mandatory,ValueFromPipeline)]
    [string]
    $FolderPath
  )
  
  process
  {
    
    $exists = Test-Path -Path $FolderPath -PathType Container
    if (!$exists) { $null = New-Item -Path $FolderPath -ItemType Directory }
  }
}