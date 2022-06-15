# Modules.PsoDownloader
Simple PowerShell command to download files from all kinds of urls including streaming sites such as YouTube or Vimeo.

## Install

To install this **PowerShell** module, run this:

```powershell
Install-Module -Name PsoDownloader -Scope CurrentUser
```

## Download

To download a file from the Internet, first get its url. This can be a static url or a url copied from YouTube, Vimeo or any other resource.
Before you start the actual download, make sure you understand the copyright of the resource you are about to download.

Next, copy the url to your clipboard, then run:

```powershell
Invoke-DownloadFile
```

As an alternative, you can look at the cmdlet parameters and submit the url to **-Url**. You can also use other parameters to determine where to store the downloaded file, to open the default player for the downloaded resource, to have Windows Explorer show the downloaded resource, and to speed up downloading by using multiple threads (**-ThrottleLimit**).

By default, the command uses 50 parallel downloads. Note that it depends on the resource whether throttling can work. Do not use a throttling above 100 as this may in turn deplete resources and slow down the entire download or make it impossible to succeed.

## Note

This module internally uses the code taken from https://github.com/yt-dlp/yt-dlp and makes it available though a really-simple-to-use **PowerShell** function. The mentioned github project is open source, just like this one. Use the code at your own risk. No warranties are made, neither expressed nor implied. 
