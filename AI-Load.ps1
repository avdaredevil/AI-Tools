function global:Convert-FromTraditional{
    [CmdletBinding()]
    Param([Parameter(ValueFromPipeline=$true)][int[]]$Data)
# =======================================START=OF=COMPILER==========================================================|
#    The Following Code was added by AP-Compiler Version [1.0] To Make this program independent of AP-Core Engine
# ==================================================================================================================|
iex ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ZnVuY3Rpb24gV3JpdGUtQVAgewpwYXJhbShbUGFyYW1ldGVyKE1hbmRhdG9yeT0kVHJ1ZSldW1N0cmluZ10kVGV4dCkNCg0KICAgIGlmICghJHRleHQgLW9yICR0ZXh0IC1tYXRjaCAiXltcK1wtXCFcKnhcPiBdKyQiKSB7cmV0dXJufQ0KICAgICRhY2MgID0gQCgoJysnLCcyJyksKCctJywnMTInKSwoJyEnLCcxNCcpLCgnKicsJzMnKSkNCiAgICAkdGIgICA9ICcnOyRmdW5jICAgPSAkZmFsc2UNCiAgICB3aGlsZSAoJFRleHQuY2hhcnMoMCkgLWVxICd4JykgeyRmdW5jID0gJHRydWU7ICRUZXh0ID0gJFRleHQuc3Vic3RyaW5nKDEpLnRyaW0oKX0NCiAgICB3aGlsZSAoJFRleHQuY2hhcnMoMCkgLWVxICc+JykgeyR0YiArPSAiICAgICI7ICRUZXh0ID0gJFRleHQuc3Vic3RyaW5nKDEpLnRyaW0oKX0NCiAgICAkU2lnbiA9ICRUZXh0LmNoYXJzKDApDQogICAgJFRleHQgPSAkVGV4dC5zdWJzdHJpbmcoMSkudHJpbSgpLnJlcGxhY2UoJy94XCcsJycpLnJlcGxhY2UoJ1suXScsJ1tDdXJyZW50IERpcmVjdG9yeV0nKQ0KICAgICR2ZXJzID0gJGZhbHNlDQogICAgZm9yZWFjaCAoJGFyIGluICRhY2MpIHtpZiAoJGFyWzBdIC1lcSAkc2lnbikgeyR2ZXJzID0gJHRydWU7ICRjbHIgPSAkYXJbMV07ICRTaWduID0gIlske1NpZ259XSAifX0NCiAgICBpZiAoISR2ZXJzKSB7VGhyb3cgIkluY29ycmVjdCBTaWduIFskU2lnbl0gUGFzc2VkISJ9DQogICAgV3JpdGUtSG9zdCAtTm9OZXdMaW5lOiRmdW5jIC1mICRjbHIgJHRiJFNpZ24kVGV4dA0KfQo=")))
# ========================================END=OF=COMPILER===========================================================|
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
