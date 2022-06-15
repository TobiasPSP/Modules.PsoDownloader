function Test-Executable
{
  param
  (
    # filepath to check
    # throws an exception if the filepath carries an extension that can be executed (on Windows)
    # by using the extensions found in the environment variable PATHEXT. On Non-Windows OS this 
    # environment variable may be missing
    [Parameter(Mandatory,ValueFromPipeline)]
    [string]
    $FilePath
  )
    
  begin
  {
    # safeguard us from accidentally downloaded executables:
    $executables = $env:pathext -split ';'
  }
  process
  {
    $extension = [System.IO.Path]::GetExtension($FilePath)
    if ($extension -in $executables) { throw "Executable found." }
    return $FilePath
  }
}