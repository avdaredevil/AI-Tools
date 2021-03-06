
# =======================================START=OF=COMPILER==========================================================|
#    The Following Code was added by AP-Compiler Version [1.2] To Make this program independent of AP-Core Engine
#    GitHub: https://github.com/avdaredevil/AP-Compiler
# ==================================================================================================================|
$Script:PSHell=$(if($PSHell){$PSHell}elseif($PSScriptRoot){$PSScriptRoot}else{"."});
iex ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ZnVuY3Rpb24gQVAtUmVxdWlyZSB7cGFyYW0oW1BhcmFtZXRlcihNYW5kYXRvcnk9JFRydWUpXVtBbGlhcygiRnVuY3Rpb25hbGl0eSIsIkxpYnJhcnkiKV1bU3RyaW5nXSRMaWIsIFtTY3JpcHRCbG9ja10kT25GYWlsPXt9LCBbU3dpdGNoXSRQYXNzVGhydSkNCg0KICAgIFtib29sXSRTdGF0ID0gJChzd2l0Y2ggLXJlZ2V4ICgkTGliLnRyaW0oKSkgew0KICAgICAgICAiXkludGVybmV0IiAge3Rlc3QtY29ubmVjdGlvbiBnb29nbGUuY29tIC1Db3VudCAxIC1RdWlldH0NCiAgICAgICAgIl5kZXA6KC4qKSIgIHtpZiAoJE1hdGNoZXNbMV0gLW5lICJ3aGVyZSIpe0FQLVJlcXVpcmUgImRlcDp3aGVyZSIgeyRNT0RFPTJ9fWVsc2V7JE1PREU9Mn07aWYgKCRNT0RFLTIpe0dldC1XaGVyZSAkTWF0Y2hlc1sxXX1lbHNle3RyeXsmICRNYXRjaGVzWzFdICIvZmpmZGpmZHMgLS1kc2phaGRocyAtZHNqYWRqIiAyPiRudWxsOyJzdWNjIn1jYXRjaHt9fX0NCiAgICAgICAgIl5saWI6KC4qKSIgIHskRmlsZT0kTWF0Y2hlc1sxXTskTGliPUFQLUNvbnZlcnRQYXRoICI8TElCPiI7KHRlc3QtcGF0aCAtdCBsZWFmICIkTGliXCRGaWxlIikgLW9yICh0ZXN0LXBhdGggLXQgbGVhZiAiJExpYlwkRmlsZS5kbGwiKX0NCiAgICAgICAgIl5mdW5jdGlvbjooLiopIiAge2djbSAkTWF0Y2hlc1sxXSAtZWEgU2lsZW50bHlDb250aW51ZX0NCiAgICAgICAgIl5zdHJpY3RfZnVuY3Rpb246KC4qKSIgIHtUZXN0LVBhdGggIkZ1bmN0aW9uOlwkKCRNYXRjaGVzWzFdKSJ9DQogICAgfSkNCiAgICBpZiAoISRTdGF0KSB7JE9uRmFpbC5JbnZva2UoKX0NCiAgICBpZiAoJFBhc3NUaHJ1KSB7cmV0dXJuICRTdGF0fQ0KfQoKZnVuY3Rpb24gUHJpbnQtTGlzdCB7cGFyYW0oJHgsIFtTd2l0Y2hdJEluUmVjdXJzZSkNCg0KICAgIGlmICgkeC5jb3VudCAtbGUgMSkge3JldHVybiA/OigkSW5SZWN1cnNlKXskeH17IlskeF0ifX0gZWxzZSB7DQogICAgICAgIHJldHVybiAiWyQoKCR4IHwgJSB7UHJpbnQtTGlzdCAkXyAtSW5SZWN1cnNlfSkgLWpvaW4gJywgJyldIg0KICAgIH0NCn0KCmZ1bmN0aW9uIEdldC1XaGVyZSB7cGFyYW0oW1BhcmFtZXRlcihNYW5kYXRvcnk9JHRydWUpXVtzdHJpbmddJEZpbGUsIFtTd2l0Y2hdJEFsbCkNCg0KICAgIEFQLVJlcXVpcmUgImRlcDp3aGVyZSIge3Rocm93ICJOZWVkIFN5czMyXHdoZXJlIHRvIHdvcmshIjtyZXR1cm59DQogICAgJE91dCA9IHdoZXJlLmV4ZSAkZmlsZSAyPiRudWxsDQogICAgaWYgKCEkT3V0KSB7cmV0dXJufQ0KICAgIGlmICgkQWxsKSB7cmV0dXJuICRPdXR9DQogICAgcmV0dXJuIEAoJE91dClbMF0NCn0K")))
# ========================================END=OF=COMPILER===========================================================|
<#===========================================> 
    Made by Apoorv Verma [AP] on 3/2/2014
    McCulloch-Pitts Perceptron
<===========================================#>
$DEBUG = $true
#=====================================ADJUSTMENT=FUNCTIONS===================================|
function tansig    ([decimal]$x) {return [Math]::Tanh($x)}
function threshold ([decimal]$x) {return [int]($x -ge 0)}
function signal    ([decimal]$x) {return (-1,1)[[int]($x -ge 0)]}
function logsig    ([decimal]$x) {return 1/(1+[Math]::Exp(-$x))}
#==================================PERCEPTRON=TEST=FUNCTIONS=================================|
function classify     ([decimal]$y,[decimal]$x,[decimal]$a,[decimal]$b) {return (-1,1)[[int]($y -ge ($a*$x+$b))]}
function gen_examples ([decimal]$num_examples,[decimal]$a,[decimal]$b) {
    $r = new-object random;$Examples = @()
    0..($num_examples-1) | % {$x1,$x2 = ($r.NextDouble()*20-10),($r.NextDouble()*20-10);$Examples += ,(($x1,$x2),(classify $x1 $x2 $a $b))}
    return $Examples
}
function load_test ($perceptron, $examples) {
    try {if (!($Examples.count-1) -or !($Examples[0].count-1)) {throw "LOL"}} catch {throw "Examples must be a 2D array"}
    $error_count = 0
    foreach ($each in $examples) {
        $input_vector = $Each[0];$desired_output = $Each[1]
        $actual_output = $perceptron.fire($input_vector)
        if ($desired_output -ne $actual_output) {$error_count++}
    }
    return $error_count
}
#=======================================PYTHON=COMMANDS======================================|
function Print-List ($x) {
    if ($x.count -le 1) {return $x} else {
        return "[$(($x | % {Print-List $_}) -join ', ')]"
    }
}
function zip ($x) {
    if ($x.count -le 1) {throw "[AP-Python] Zip argument #1 must support iteration"}
    $cnt = $x[0].count
    $x | % {$_.count} | % {if ($_ -lt $cnt) {$cnt = $_}}
    $Array = New-Object Object[][] $Cnt,$x.count
    0..($Cnt-1) | % {
        $i = $_
        0..($x.count-1) | % {$Array[$i][$_] = $x[$_][$i]}
    }
    return $Array
}
#=====================================NEURON=&=PERCEPTRON====================================|
Function New-Neuron {
    param ([Parameter(Mandatory=$True)][decimal[]]$weights,[decimal]$bias=0,[ValidateSet("threshold","signal","logsig","tansig")][String]$activation="threshold")
    $Neuron = New-Object -TypeName PSObject
    "weights","bias","activation" | % {
        $Neuron | Add-Member -MemberType NoteProperty -Name $_ -Value (gv $_).Value
    }
    $Neuron | Add-Member -MemberType ScriptMethod -Name fire -Value {
        param([decimal[]]$inputs)
        if ($Debug) {write-host -f 2 "Weights = $(Print-List $This.Weights) || Inputs = $(Print-List $Inputs)"}
        if ($inputs.count -ne $this.Weights.count) {throw "Weights and inputs are not of same size"}
        $Summed = 0
        zip($inputs,$this.Weights) | % {$Summed += $_[0]*$_[1]}
        return iex "$($this.activation)(`$summed + `$this.bias)"
    }
    $Neuron | Add-Member -MemberType ScriptMethod -Name update -Value {
        param([decimal[]]$input_vector, [decimal]$factor)
        $This.weights = zip($This.weights, $input_vector) | % {$_[0] + $factor*$_[1]}
        $This.bias    = $This.bias + $factor
    }
    return $Neuron
}
Function New-Perceptron {
    param (
        [Parameter(Mandatory=$True)][int]$input_size,
        [decimal[]]$weights,
        [decimal]$bias=0,
        [ValidateSet("threshold","signal","logsig","tansig")][String]$activation="threshold",
        [decimal]$lrn_rate=1
    )
    $Perceptron = New-Object -TypeName PSObject
#  |----------|
    if (!$weights) {$weights = (,0)*$input_size}
    $neuron   = New-Neuron $weights $bias $activation
#  |----------|
    "input_size", "weights", "bias", "activation","lrn_rate","neuron" | % {
        $Perceptron | Add-Member -MemberType NoteProperty -Name $_ -Value (gv $_).Value
    }
#  |----------|
    $Perceptron | Add-Member -MemberType ScriptMethod -Name fire -Value {
        param([decimal[]]$inputs)
        $This.neuron.fire($inputs)
    }
    $Perceptron | Add-Member -MemberType ScriptMethod -Name training -Value {
        param($examples, [int]$max_epochs)
        try {if (!($Examples.count-1) -or !($Examples[0].count-1)) {throw "LOL"}} catch {throw "Examples must be a 2D array"}
        $epochs = 0
        while ($True) {
            $epochs++
            $error_count = 0
            Foreach ($Part in $Examples) {
                $input_vector = $Part[0];$desired_output = $Part[1]
                $actual_output = $this.neuron.fire($input_vector)
                $error = $desired_output - $actual_output
                if ($Error) {
                    $learned = $This.lrn_rate*$error
                    if ($Debug) {Write-Host -f 2 "Input Vector : $(Print-List $input_vector)`nLearned = $Learned`nCurrent wights : $(Print-List $this.neuron.weights)"}
                    $This.neuron.update($input_vector, $learned)
                    $error_count++
                }
            }
            if (!$Error_Count) {break}
            if ($max_epochs -and $epochs -gt $max_epochs) {return $False}
        }
        return $epochs
    }
    return $Perceptron
}
Function New-Layer {
    param (
        [Parameter(Mandatory=$True)][int]$input_size,
        [ValidateRange(2,99999)][int]$num_perceptrons=2,
        [decimal[]]$lrn_rates=(,1)*$num_perceptrons,
        [String[]]$activations="threshold"*$num_perceptrons
    )
    $Layer = New-Object -TypeName PSObject
    $Perceptrons = @()
    if (($activations.count+$lrn_rates.count)/$num_perceptrons -ne 1) {throw "Activations-Lrn_Rates-num_perceptrons do not match up"}
#  |----------|
    foreach ($Data in Zip($lrn_rates,$activations)) {
        $Perceptrons += New-Perceptron $input_size -lrn_rate $Data[0] -activation $Data[1]
    }
#  |----------|
    "input_size", "num_perceptrons", "lrn_rates","activations","Perceptrons" | % {
        $Perceptron | Add-Member -MemberType NoteProperty -Name $_ -Value (gv $_).Value
    }
#  |----------|
    $Layer | Add-Member -MemberType ScriptMethod -Name fire -Value {
        param([decimal[]]$inputs)
        $Ans = @();foreach ($pn in $Perceptrons) {$Ans += ,$pn.fire($inputs)}
        return $Ans
    }
    $Layer | Add-Member -MemberType ScriptMethod -Name training -Value {
        param($inputs_vector, $outputs_vector, [int]$max_epochs)
        $epochs = 0
        foreach ($Data in zip($This.perceptrons,$outputs_vector)) {
            $perceptron = $Data[0];$outputs = $Data[1]
            $epochs_per_perceptron = $perceptron.training($inputs_vector,$outputs,$max_epochs)
            if (!$epochs_per_perceptron) {return $epochs_per_perceptron}
            $epochs += $epochs_per_perceptron
        }
        return $epochs
    }
    return $Layer
}
#============================================================================================|
#======================================TESTS=FOR=N&P=========================================|
#============================================================================================|
#=========[Neuron]=========>
$neuron_1 = New-Neuron 0.4,0.6,0.9 -0.8
$neuron_2 = New-Neuron 0.4,0.6,0.9 -1.5 signal
$neuron_3 = New-Neuron 0.4,0.6,0.9 -0.8 logsig
$neuron_4 = New-Neuron 0.4,0.6,0.9 -0.8 tansig

$inputs = 1,0,1

Write-Host -f Yellow "Test #1 - inputs on neuron_1:", $neuron_1.fire($inputs)
Write-Host -f Yellow "Test #1 - inputs on neuron_2:", $neuron_2.fire($inputs)
Write-Host -f Yellow "Test #1 - inputs on neuron_3:", $neuron_3.fire($inputs)
Write-Host -f Yellow "Test #1 - inputs on neuron_4:", $neuron_4.fire($inputs)
#=========[Perceptron]=====>
Write-Host -f Yellow "$('='*[Math]::Floor(([Console]::BufferWidth-16)/2))Perceptron-Test$('='*[Math]::Ceiling(([Console]::BufferWidth-16)/2))"
$p        = New-Perceptron 2

Write-Host -f Yellow "#TRAINING:"
$examples = gen_examples   8 -5 2 # Generates 8 Points to train against!
if ($Debug) {write-Host -f 3 (Print-List $Examples)}
Write-Host -f Yellow "    Generated Examples"
$epochs = $p.training($examples)
Write-Host -f Yellow "    Epochs: $epochs`n"

Write-Host -f Yellow "#TESTING:"
$examples = gen_examples   8 -5 2
Write-Host -f Yellow "    Generated Examples"
$error_count = load_test($p, $examples)
Write-Host -f Yellow '    Error Count:', $error_count
