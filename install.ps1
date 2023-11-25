# カレントディレクトリに移動
Set-Location -Path $PSScriptRoot
Write-Host $PSScriptRoot

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
  irm get.scoop.sh | iex
} else {
  Write-Host "Scoopは既にインストールされています。"
}

scoop install git

scoop bucket add extras
scoop bucket add versions

# Get-Content scoop_install_apps.txt | ForEach-Object { scoop install $_ }

scoop install deno
scoop install gcc
scoop install gh
scoop install neovim
scoop install powertoys
scoop install python39
scoop install ripgrep
scoop install tree-sitter
scoop install universal-ctags
scoop install vim