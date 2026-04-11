# -------------------------------------------------------------
# Script Automático de Sincronização LADDER
# Faz o commit automático se o arquivo SMD_Application mudou.
# -------------------------------------------------------------

$repoPath = "C:\Users\francisco.paixao\Desktop\projeto-teste"
$dateStr = Get-Date -Format "yyyy-MM-dd HH:mm"

Set-Location $repoPath

# Verifica se existe mudança nos rungs / tags
$status = git status --porcelain

if ($status) {
    Write-Host "Modificacoes encontradas no Studio 5000! Criando backup Automatico..."
    git add .
    git commit -m "Auto-backup PLCs $dateStr"
    
    Write-Host "Enviando pro GitHub..."
    git push origin main
} else {
    Write-Host "Nenhuma mudança no Studio 5000 hoje. Tudo certo."
}
