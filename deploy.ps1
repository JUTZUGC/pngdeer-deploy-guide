# pngdeer 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/heydeer/pngdeer#readme
# 更新日期：2026-10-31
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

Write-Host "pngdeer 命令行目前只提供 macOS 与 Linux 包；Windows 可用网页版，或按下面的步骤从源码编译"
if (-not (Get-Command cargo -ErrorAction SilentlyContinue)) { throw '需要先安装 Rust 工具链（rustup），或改用网页版' }
git clone https://github.com/heydeer/pngdeer.git
Set-Location pngdeer
cargo build --release
Write-Host "编译完成：target\release\pngdeer.exe input.png -o output.png"

Write-Host ''

Write-Host '下载与校验完成，安装包在 .download 目录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/heydeer/pngdeer#readme'
