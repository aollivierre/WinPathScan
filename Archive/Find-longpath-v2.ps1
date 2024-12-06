function Get-LongPathItems {
    param (
        [string]$Path,
        [int]$Limit = 255
    )

    # Determine the path where the script is located
    $scriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

    # Construct the CSV file path in the script's directory
    $ExportCsvPath = Join-Path -Path $scriptRoot -ChildPath "LongPathsReport.csv"

    # Ensure the provided path exists
    if (Test-Path $Path) {
        # Initialize a List to hold the results
        $results = New-Object System.Collections.Generic.List[Object]

        # Get all files and directories recursively
        Get-ChildItem -Path $Path -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName.Length -gt $Limit } | ForEach-Object {
            # Add the item to the results list
            $results.Add([PSCustomObject]@{
                Type   = if ($_.PSIsContainer) { 'Directory' } else { 'File' }
                Path   = $_.FullName
                Length = $_.FullName.Length
            })
        }

        # Export results to CSV
        $results | Export-Csv -Path $ExportCsvPath -NoTypeInformation
        Write-Host "Exported results to '$ExportCsvPath'."

        # Display total count
        $totalCount = $results.Count
        Write-Host "Total items found with path length greater than $Limit characters: $totalCount"
    } else {
        Write-Warning "The path '$Path' does not exist."
    }
}
