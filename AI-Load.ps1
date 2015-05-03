# =======================================START=OF=COMPILER==========================================================|
#    The Following Code was added by AP-Compiler Version [1.0] To Make this program independent of AP-Core Engine
# ==================================================================================================================|
iex ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ZnVuY3Rpb24gV3JpdGUtQVBBUC1SZXF1aXJlIHt9Cg==")))
# ========================================END=OF=COMPILER===========================================================|
function global:Convert-FromTraditional{
    [CmdletBinding()]
    Param([Parameter(ValueFromPipeline=$true)][int[]]$Data)
    Process
    {
        return $data | % {![Bool][Math]::Sign(([Math]::Sign($_)*-1+1))}
    }
}
function global:Convert-ToTraditional{
    [CmdletBinding()]
    Param([Parameter(ValueFromPipeline=$true)][bool]$Data)
    Process
    {
        return $data | % {if ($_) {1} else {-1}}
    }
}
function global:Upload-DataSet([Parameter(Mandatory=$true)][ValidatePattern("..*")]$File){
    $File = "$(Resolve-Path $File)"
    $Hash = @{}
    Try {
        [IO.File]::ReadAllLines($File) | % {$Data = $_.Split("|");$Hash += @{[Decimal[]]$Data[0].split(",")=(Convert-FromTraditional [int]$Data[1]| Convert-ToTraditional)}}
    } Catch {
        Write-AP "-File Incorrectly Formatted!"
    }
    Return $Hash
}
function global:Download-DataSet([Parameter(Mandatory=$true)][HashTable]$Data,[Parameter(Mandatory=$true)][ValidatePattern("..*")]$File){
    $Data.GetEnumerator() | % {
        "$(($_.Name | % {"$_"}) -join ",")|$($_.Value)"
    } | Out-File -Encoding Default $File
}
