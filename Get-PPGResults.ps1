$VideoResults = @()
$QuoteQuery = Read-Host "Enter your search query: "
$SearchResultsURL = 'https://pigpiggo.net/ppg-api/captions?keyword=' + $QuoteQuery
$SearchResultsData = (Invoke-WebRequest -Uri $SearchResultsURL -Method Get -UseBasicParsing | ConvertFrom-Json)
foreach($item in $SearchResultsData) {
    #$Text = "Found text: " + $QuoteQuery

    $Fullstat = New-Object System.Object
    
    $timestampminutes = [string]([timespan]::FromSeconds($length)).minutes
    $timestampseconds = [string]([timespan]::FromSeconds($length)).seconds
    $TimestampToDisplay = $timestampminutes + "m" + $timestampseconds + "s"
    $Uploaded = $item.uploaded
    $Text = $item.text
    $Video = "https://www.youtube.com/watch?v=" + $item.video_id
    
    $Fullstat | Add-Member -Type NoteProperty -Name ResultsID -Value $item.id
    $Fullstat | Add-Member -Type NoteProperty -Name Count -Value $item.count
    $Fullstat | Add-Member -Type NoteProperty -Name Title -Value $item.title
    $Fullstat | Add-Member -Type NoteProperty -Name Length -Value $item.length
    $Fullstat | Add-Member -Type NoteProperty -Name Timestamp -Value $TimestampToDisplay
    $Fullstat | Add-Member -Type NoteProperty -Name VideoUploadDate -Value $item.uploaded
    $Fullstat | Add-Member -Type NoteProperty -Name WhatDidHeSay -Value $item.text
    $Fullstat | Add-Member -Type NoteProperty -Name YTURL -Value $video
    
    $VideoResults += $Fullstat

}

<#
INFO FOR LATER

SAMPLE RESULT
id         : 314765
video_id   : 0yfJoXzZleY
text       : high level mm-hmm equipment that you can
time       : 2551
title      : Shenmue III playthrough pt17 - Return of the Forklift!
length     : 3666
thumbnail  : https://i.ytimg.com/vi/0yfJoXzZleY/sddefault.jpg
uploaded   : 2019-12-15T00:00:00.000Z
full_count : 930

CONVERT TIME
$entry = $SearchResultsData[0]
$length = $entry.time
$timestampminutes = ([timespan]::FromSeconds($length)).minutes
$timestamp seconds = ([timespan]::FromSeconds($length)).seconds
$realtime = [timespan]::FromSeconds($length)
