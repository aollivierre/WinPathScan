# Windows Path Length Analyzer (WinPathScan)

A PowerShell tool for analyzing and reporting file path lengths in Windows environments, specifically designed to help with cloud migration readiness and OneDrive sync compatibility.

## Overview

WinPathScan helps IT administrators and users identify and resolve long file path issues that commonly cause problems with:
- OneDrive sync
- SharePoint Online migration
- Teams file sync
- Windows system limitations

The tool provides detailed reports of files and folders that exceed specified path length limits, helping prevent sync issues before they occur.

## Features

- 🔍 Recursive path length analysis
- 📊 HTML and CSV reporting options
- 🎨 Color-coded length severity indicators
- 📝 Path remediation suggestions
- 📂 NTFS permissions analysis (optional)
- 📈 Detailed statistics and summaries

## Prerequisites

- Windows OS (Windows 10, Windows 11, or Windows Server)
- PowerShell 5.1 or PowerShell 7.x (tested with PS 7.4.6)
- Administrator privileges (for certain paths)

## Installation

1. Clone the repository:
```powershell
git clone https://github.com/YourUsername/WinPathScan.git
```

2. Install required PowerShell modules (requires PowerShell 5.1):
```powershell
.\0-Install-RequiredModules.ps1
```

## Usage

```powershell
# Basic usage
.\Get-LongPathAnalysis.ps1 -Path "C:\Users" -Limit 260

# Full analysis with all features
.\Get-LongPathAnalysis.ps1 -Path "C:\Users" -Limit 260 -ExportFormat "Both" -IncludePermissions
```

### Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| Path | Directory to analyze | (Required) |
| Limit | Maximum path length to flag | 400 |
| ExportFormat | Output format (HTML/CSV/Both) | HTML |
| IncludePermissions | Include NTFS permissions | False |

## Output

The tool generates reports in your specified format(s):
- HTML report with interactive tables and filters
- CSV export for further analysis
- Console summary of findings

Reports include:
- Total items exceeding limit
- Path length statistics
- Access errors encountered
- Remediation suggestions

## Common Use Cases

1. **OneDrive Migration Planning**
   - Identify paths that would break OneDrive sync
   - Get suggestions for path restructuring

2. **SharePoint Online Readiness**
   - Verify compatibility with SharePoint path limits
   - Export reports for migration planning

3. **Teams File Sync Preparation**
   - Ensure file paths will sync properly with Teams
   - Identify problematic folder structures

## Known Limitations

- Requires appropriate permissions to access scanned directories
- Some features require administrator privileges
- Performance may vary with large directory structures
- HTML report generation requires Edge, Chrome or FireFox or Safari or any modern Chromium based browser

## Best Practices

- Start with smaller directory structures to understand the output
- Use the `-IncludePermissions` switch only when necessary (impacts performance)
- Review both HTML and CSV reports for different insights
- Address longest paths first for maximum impact

## Troubleshooting

If you encounter issues:

1. Ensure you have required permissions
2. Verify PowerShell execution policy allows script execution
3. Check that required modules are installed
4. Run as administrator for system directories

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - feel free to use and modify as needed.

## Acknowledgments

- PSWriteHTML module for report generation
- PowerShell community for testing and feedback

## Author

[Your Name/Organization]

## Version History

- 1.0.0 - Initial release
- 1.0.1 - Added PowerShell 7.x support
- 1.1.0 - Enhanced reporting features