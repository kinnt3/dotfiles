Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

Function MakeLink {
    param (
        [string]$target,
        [string]$link
    )

    # ファイルを消す
    Remove-Item -Path $target -Recurse -Force -ErrorAction SilentlyContinue

    # リンクを貼る
    New-Item -ItemType SymbolicLink -Path $target -Value $link -Force
    Write-Host ""
}

# カレントディレクトリに移動
Set-Location -Path $PSScriptRoot
Write-Host $PSScriptRoot

MakeLink "$env:USERPROFILE\AppData\Local\nvim" "$PSScriptRoot\nvim"

Read-Host "Press Enter to continue..."


