# pngdeer 一键安装指南

> 第三方部署指南 · 非 pngdeer 官方仓库。官方项目：[heydeer/pngdeer](https://github.com/heydeer/pngdeer)
> 内容来自官方文档（2026-10-31）。项目迭代快，请以[官方文档](https://github.com/heydeer/pngdeer#readme)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 同一档观感下，中位图比 TinyPNG 再小 8–12%：它把调色板大小与抖动组合都试一遍再挑。

⚠️ 命令行只支持 macOS 与 Linux，用 Homebrew 安装；Windows 没有预编译命令行，只能用网页版或自己装 Rust 工具链编译。网页版在浏览器里用 WebAssembly 跑同一套 Rust 代码，图片不上传，支持的图最大约 4000 万像素。它是会丢信息的压缩，重要原图请先备份。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/pngdeer-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按系统选安装方式，macOS 与 Linux 走 Homebrew，Windows 走源码编译或网页版，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## pngdeer 是什么？

pngdeer 是开源的不给质量滑杆：工具自己从 2 到 256 色里搜一遍，按感知指标挑出最小的那个文件（协议：MIT，<img src="https://img.shields.io/github/stars/heydeer/pngdeer?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

感知优化的 PNG 压缩：对每张图搜索调色板大小与抖动组合，用 SSIMULACRA2 打分，保留观感达标的最小文件；也能重编码 JPEG、处理多帧 APNG。

- 不用调参：质量由工具自己判断
- 比 TinyPNG 更小：中位图再小 8–12%
- 同一套代码：命令行与网页输出完全一致
- 动图不丢帧：APNG 逐帧统一调色板并保留时间轴
- JPEG 也能压：用 mozjpeg 重编码
- MIT 协议，可自由使用

（来源：[官方仓库](https://github.com/heydeer/pngdeer)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 4 | 0 |
| 不 | 用 |
| 同 | 观 |
| 命 | 令 |
| 支 | 持 |
| M | I |

| 需要注意 | 说明 |
|---|---|
| 命 | 令 |
| 网 | 页 |
| 有 | 损 |
| 只 | 有 |
| 项 | 目 |

> 以上基于官方文档与社区反馈整理（2026-10-31），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
brew install heydeer/tap/pngdeer
pngdeer --version
echo "安装完成：pngdeer input.png -o output.png"
```

安装包来源：[https://github.com/heydeer/pngdeer#readme](https://github.com/heydeer/pngdeer#readme)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 Homebrew 与源码编译两种方式、平台限制与网页版 | 已核对 2026-10-31 |
| README 确认与 TinyPNG 等工具的对比数据与 MIT 协议 | 已核对 2026-10-31 |
| 未实测安装与压缩效果 | 说明 2026-10-31 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-31 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-31 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供安装方式、用法与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-31）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\pngdeer-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 三种使用方式

| 方式 | 平台 | 说明 |
|---|---|---|
| Homebrew | macOS、Linux | `brew install heydeer/tap/pngdeer` |
| 源码编译 | 全平台 | 装 Rust 后 `cargo build --release`，产物在 `target/release/pngdeer` |
| 网页版 | 任意现代浏览器 | 打开官方开源页面，图片在本机压缩，不上传 |

## 基本用法

```bash
pngdeer input.png -o output.png
```

不给参数时它会自己决定质量，不会把画面压糊；批量处理时按文件逐个跑。

## 和其它工具比

官方在 180 张图上和 TinyPNG、pngquant、ImageMagick、Pillow 等做了对比：同观感下中位图比 TinyPNG 小 8–12%，用另一套感知指标 butteraugli 复核仍有 6–9% 优势。

## 注意

- 命令行只有 macOS 与 Linux 的现成包
- Windows 用网页版最省事，编译需要 Rust 工具链
- 属于有损压缩，重要原图先备份
- 网页版有像素上限，超大图请在命令行处理
- 动图会统一调色板，颜色特别丰富时可能可见色带

## 常见坑

- Windows 装不了命令行：用网页版，或先装 rustup 再编译
- brew 找不到包：先 `brew tap heydeer/tap` 再装
- 编译报错：确认 Rust 版本较新，缺依赖按提示装
- 压完颜色发灰：该图颜色太丰富，改用无损工具
- 动图掉帧：确认源文件是标准 APNG，转码后再试
- 网页版打不开大图：换命令行处理

## 免责声明

本仓库为第三方指南，与 pngdeer 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-31），项目迭代快，请以[官方文档](https://github.com/heydeer/pngdeer#readme)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
