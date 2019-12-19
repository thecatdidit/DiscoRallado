$VideoResults = @()
$QuoteQuery = Read-Host "Enter your search query: "
$SearchResultsURL = 'https://pigpiggo.net/ppg-api/captions?keyword=' + $QuoteQuery
$SearchResultsData = (Invoke-WebRequest -Uri $SearchResultsURL -Method Get -UseBasicParsing | ConvertFrom-Json)
foreach($item in $SearchResultsData) {
    #$Text = "Found text: " + $QuoteQuery
    $Count = $item.full_count
    $Title = $item.title
    $Uploaded = $item.uploaded
    $Total = "Total Number of Results: " + $Count
    $Video = "https://www.youtube.com/watch?v=" + $item.video_id
    Write-Output $Title
    Write-Output $Uploaded
    Write-Output $Count
    Write-Output $Video
}