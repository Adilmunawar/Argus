@{
    RootModule        = 'ZDCloud.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = '5f1c9a2e-3b7d-4c8a-9e21-7d0c1f6a8b44'
    Author            = 'Zaraat Dost Platform'
    Description       = 'Client for the ZD Cloud Console API. Every command opens a pull request or reads state; none has privileges of its own.'
    PowerShellVersion = '7.4'
    FunctionsToExport = @('Connect-ZdCloud','Get-ZdOverview','Get-ZdApp','Publish-ZdApp','Approve-ZdDeployment','Get-ZdBackup','New-ZdDatabaseCredential','Grant-ZdTierAccess','Invoke-ZdRunbook','Get-ZdAudit')
}
