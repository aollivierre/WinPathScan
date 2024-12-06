function Get-LongPathItems {
    param (
        [string]$Path,
        [int]$Limit = 255
    )

    # Ensure the provided path exists
    if (Test-Path $Path) {
        # Get all items recursively
        Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.FullName.Length -gt $Limit } | ForEach-Object {
            # Output the path and the length of each item found
            [PSCustomObject]@{
                Path   = $_.FullName
                Length = $_.FullName.Length
            }
        }
        Get-ChildItem -Path $Path -Recurse -Directory -ErrorAction SilentlyContinue | Where-Object { $_.FullName.Length -gt $Limit } | ForEach-Object {
            # Output the path and the length of each directory found
            [PSCustomObject]@{
                Path   = $_.FullName
                Length = $_.FullName.Length
            }
        }
    } else {
        Write-Warning "The path '$Path' does not exist."
    }
}


Get-LongPathItems -Path 'C:\Users\user\UpHouse Inc'




