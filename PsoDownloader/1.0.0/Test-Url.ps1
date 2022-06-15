function Test-Url
{
  param
  (
    [Parameter(Mandatory,ValueFromPipeline)]
    [string]
    $Url,
    
    [string]
    $Message = 'No valid url'
  )
  begin
  {
    $urlRegex = '^https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,}$'
  }
  process
  {
    if ($Url -notmatch $urlregex) { throw $Message }
    return $Url
  }
}