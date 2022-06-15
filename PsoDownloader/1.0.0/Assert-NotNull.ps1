function Assert-NotNull
{
  param
  (
    [Parameter(ValueFromPipeline)]
    [string]
    $String = '',
    
    [string]
    $Message = 'String is empty.'
  )
  
  process
  {
    if ([string]::IsNullOrWhiteSpace($String))
    {
      throw $Message
    }
    return $String
  }
}