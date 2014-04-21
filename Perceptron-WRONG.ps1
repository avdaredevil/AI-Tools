param(
    [Alias("TrainingSet")][Parameter(Mandatory=$true)][Hashtable]$Data,
    [decimal]$Threshold = 0,
    [Parameter(Mandatory=$true)][decimal]  $Epsilon,
    [Alias("Beta","LearningRate")][decimal]$LR = .5,
    [Switch]$IncludeData
)
#------------------------------------------------|
function Dot-Product ($Vec1,$Vec2) {
    $Sum = 0
    0..($Vec1.count-1) | % {$Sum += $Vec1[$_]+$Vec2[$_]}
    return $Sum
}
[decimal[]] $W = 1..($Data.KEYS | select -Last 1).Length | % {Get-Random -Maximum 2}
[Decimal]$Error = 0
$Iter  = 0
#---------
do {
    $X = $Data.GetEnumerator() | Get-Random
    $y = $X.Value; $X = $X.Name
	Write-Host -f 3 "W*X = [$($W -join(', '))] * [$($X -join(', '))]"
    $h = Dot-Product $W $X
    $Error = [Math]::Abs($y - [Math]::Sign($h-$Threshold))
    $W = 0..($W.Length-1) | % {$W[$_] + $LR*$Error*$X[$_]}
    Write-Host -f 2 "Error : $Error"
} while ($Error -gt $Epsilon)
Write-Host -f yellow "[$($W -join(', '))]"
#------------------------------------------------|
Add-Type @"
public class PerceptronResults {
    public int DataCount;
    public decimal   Sum;
    public bool   Result;
    public decimal Threshold;
    public decimal[]  Errors;
    public decimal[]    Data;
    public decimal[] Answers;
    public decimal[] Weights;
    public PerceptronResults (int DC, decimal SM, decimal TH) {
        DataCount = DC;
        Sum       = SM;
        Threshold = TH;
        Result    = (Sum > Threshold);
    }
}
"@            
#------------------------------------------------|
#$Obj = New-Object PerceptronResults($Data.count,$Sum,$Threshold)
#$Obj.Errors = $Errors
#if ($IncludeData) {
#    $Obj.Data    = $Data
#    $Obj.Weights = $Weights
#    $Obj.Answers = $Weights
#}
#------------------------------------------------|
return $Obj
