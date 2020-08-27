
$check = $null
do {
    if ($null -eq $check) {
        $path_rep = Read-Host -Prompt 'Saisir un repertoire'
    }
    else {
        $path_rep = Read-Host -Prompt 'Erreur, saisir un repertoire valide'
    }
    $check = Test-Path $path_rep
} while ($check -eq $FALSE)


$check = $null
do {
    if ($null -eq $check) {
        $ext_saisi = Read-Host -Prompt 'Donnez une extension de fichier a zipper (txt, log, js...)'
        $ext = "*." + $ext_saisi
    }
    else {
        $ext_saisi = Read-Host -Prompt 'Erreur, saisir une extension valide (txt, log, js...)'
        $ext = "*." + $ext_saisi
    }
    $files = Get-ChildItem $path_rep* -Include $ext -Recurse -Force
} while ($null -eq $files)

$files

$check = $null
do {
    if ($null -eq $check) {
        $path = Read-Host -Prompt 'Saisir un repertoire pour le zip'
    }
    else {
        $path = Read-Host -Prompt 'Erreur, saisir un repertoire valide pour le zip'
    }
    $check = Test-Path $path
} while ($check -eq $FALSE)

for (; ; ) {
    $files = Get-ChildItem $path_rep* -Include $ext -Recurse -Force
    "il y'a " + $files.count + "fichiers"
    if ($null -ne $files) {
        $date = Get-Date -Format "yyyyMMdd_HHmm"
        $pathzip = $path + "\" + $ext_saisi + "_" + $date 
        Compress-Archive -Path $files -DestinationPath $pathzip -Force
    }
    Start-Sleep -s 60
}
