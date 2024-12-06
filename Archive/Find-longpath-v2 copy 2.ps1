

<#
.SYNOPSIS
Finds and exports paths exceeding a specified length within a given directory to a CSV file in a predefined script root directory.

.DESCRIPTION
This PowerShell function searches recursively through a given directory for files and directories where the path length exceeds a specified limit (default 255 characters). It then exports the results to a CSV file within a predefined script root directory.

.PARAMETER Path
The directory path to search for long path names.

.PARAMETER Limit
The character limit to consider a path name "long". Default is 255.

.EXAMPLE
Get-LongPathItems -Path "C:\ExamplePath" -Limit 260

Searches through "C:\ExamplePath" for paths longer than 260 characters and exports the results to a CSV file in the script root directory.

.NOTES
Make sure to define $PSScriptRoot variable to specify the root directory for the CSV export.

#>


Install-Module PSWriteHTML
Import-Module PSWriteHTML

function Get-LongPathItems {
    param (
        [string]$Path,
        [int]$Limit = 255
    )

    $ExportHtmlPath = Join-Path -Path $PSScriptRoot -ChildPath "LongPathsReport.html"

    if (Test-Path $Path) {
        $results = Get-ChildItem -Path $Path -Recurse -ErrorAction SilentlyContinue | 
                   Where-Object { $_.FullName.Length -gt $Limit } | 
                   ForEach-Object {
                       [PSCustomObject]@{
                           Type = if ($_.PSIsContainer) { 'Directory' } else { 'File' }
                           Path = $_.FullName
                           Length = $_.FullName.Length
                       }
                   }

        New-HTML -Title "Long Paths Report" -FilePath $ExportHtmlPath -ShowHTML {
            New-HTMLSection -HeaderText "Files and Directories Exceeding $Limit Characters" {
                New-HTMLTable -DataTable $results
            }
        }

        Write-Host "Exported results to '$ExportHtmlPath'. Total items found: $($results.Count)"
    } else {
        Write-Warning "The path '$Path' does not exist."
    }
}


# Example of calling the function
Get-LongPathItems -Path "C:\Users\user\UpHouse Inc"