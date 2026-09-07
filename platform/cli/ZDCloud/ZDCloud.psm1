# ZDCloud — PowerShell client for the ZD Cloud Console API (signed; in the WDAC policy).
$script:BaseUrl = $env:ZDCLOUD_URL ?? 'https://console.zaraatdost.pk/api/v1'
$script:Token   = $null

function Connect-ZdCloud {
    [CmdletBinding()] param([string]$Authority = 'https://adfs.zd.local/adfs')
    # OIDC device-code flow against AD FS; token cached with DPAPI for the current user.
    $script:Token = Get-ZdDeviceCodeToken -Authority $Authority -ClientId 'zd-cli' -Scope 'openid zd-console'
    Write-Host "Connected to $script:BaseUrl"
}

function Invoke-Zd {
    param([string]$Method, [string]$Path, $Body)
    if (-not $script:Token) { throw 'Run Connect-ZdCloud first.' }
    $p = @{ Method = $Method; Uri = "$script:BaseUrl$Path"; Headers = @{ Authorization = "Bearer $script:Token" }; ContentType = 'application/json' }
    if ($Body) { $p.Body = ($Body | ConvertTo-Json -Depth 8) }
    Invoke-RestMethod @p
}

function Get-ZdOverview { Invoke-Zd GET '/overview' }
function Get-ZdApp { param([string]$Name) if ($Name) { Invoke-Zd GET "/apps/$Name" } else { Invoke-Zd GET '/apps' } }

function Publish-ZdApp {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(Mandatory)][string]$Name, [Parameter(Mandatory)][string]$Version, [ValidateSet('staging','production')][string]$Environment = 'staging')
    if ($PSCmdlet.ShouldProcess("$Name $Version → $Environment", 'Open deployment pull request')) {
        $r = Invoke-Zd POST "/apps/$Name/deploy" @{ version = $Version; environment = $Environment }
        Write-Host "Pull request: $($r.prUrl)"; $r
    }
}

function Approve-ZdDeployment { param([Parameter(Mandatory)][int]$Id) Invoke-Zd POST "/deployments/$Id/approve" }
function Get-ZdBackup { param([Parameter(Mandatory)][string]$Database, [int]$Last = 10) Invoke-Zd GET "/databases/$Database/backups?last=$Last" }
function New-ZdDatabaseCredential { param([Parameter(Mandatory)][string]$Database, [string]$Ttl = '1h') Invoke-Zd POST "/databases/$Database/credentials" @{ ttl = $Ttl } }
function Grant-ZdTierAccess { param([Parameter(Mandatory)][string]$Group, [int]$Hours = 2, [Parameter(Mandatory)][string]$Reason) Invoke-Zd POST '/identity/grants' @{ group = $Group; hours = $Hours; reason = $Reason } }
function Invoke-ZdRunbook { param([Parameter(Mandatory)][string]$Id, [hashtable]$Param = @{}) Invoke-Zd POST "/runbooks/$Id/run" @{ params = $Param } }
function Get-ZdAudit { param([datetime]$Since = (Get-Date).AddHours(-24)) Invoke-Zd GET "/audit?since=$($Since.ToUniversalTime().ToString('o'))" }
