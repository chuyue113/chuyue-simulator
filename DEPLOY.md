# chuyue 网页模拟器 — GitHub Pages 部署指南

全程浏览器手动操作，不需要任何 Token，你的密钥零暴露。

> **重要提示**：GitHub 仓库名**不支持中文**，请使用英文名。
> 本指南统一使用建议名 `chuyue-simulator`（chuyue 新版网页模拟器），
> 你也可以自选英文名，只需把后面命令里的 `chuyue-simulator` 替换成你的名字。

---

## 要部署的文件（已放好，共 4 项）

| 文件 | 说明 |
| --- | --- |
| `index.html` | 主页 · 国风主题 · 支持四语言 / 四主题 / 桌面平板手机三模式 |
| `settings.html` | 系统设定 · INS 风格 |
| `cool-version/` | 酷暗色版本（备选） |
| `setup.sh` | 一键推送脚本（你复制命令即可） |

---

## 第 1 步：浏览器创建仓库（约 1 分钟）

1. 打开 **https://github.com/new**（需已登录你的 GitHub 账号）
2. **Repository name** 填：`chuyue-simulator`
3. **Visibility** 选 **Public**（公开）
   - 说明：免费账号的 GitHub Pages 只对公开仓库开放访问；选 Private 页面无法公开访问
4. **不要**勾选 "Add a README file"（避免和本地提交冲突）
5. 点击绿色按钮 **Create repository**
6. 创建后页面会显示一个仓库地址，复制它（形如 `https://github.com/你的用户名/chuyue-simulator.git`）
   - 如果创建时你没把仓库名改成别的，地址的后半段就是 `chuyue-simulator.git`

---

## 第 2 步：在 Git Bash 里执行一键脚本

在你的 Windows 上打开 **Git Bash**（开始菜单搜索 Git Bash），然后执行：

```bash
cd "C:/Users/USER/.qianfan/workspace/67310f27081b4b88a8fdf7f50f8cd21b/chuyue-deploy"
bash setup.sh
```

脚本会提示你输入 **GitHub 用户名** 和 **仓库名**，然后自动完成：
初始化 git → 添加文件 → 提交 → 推送到 GitHub。

> 若之前从未用 git 提交过代码，脚本会先提示你设置一次全局昵称和邮箱（只需一次）。

---

## 第 3 步：浏览器开启 GitHub Pages（约 30 秒）

1. 回到刚才的仓库页面，点击顶部标签 **Settings**
2. 左侧菜单点 **Pages**（在 Code and automation 分组下）
3. **Branch** 选择 `main`，文件夹选择 `/ (root)`，点 **Save**
4. 等待约 1 分钟，页面顶部会出现提示：
   `Your site is live at https://你的用户名.github.io/chuyue-simulator/`

---

## 第 4 步：验证网站

浏览器打开上述网址，你会看到：

- **首页**：chuyue 国风主题主页（右上角可切换 语言 / 主题 / 桌面平板手机 模式）
- 在网址后手动加 `settings.html` 可打开系统设定页
  → `https://你的用户名.github.io/chuyue-simulator/settings.html`

---

## 以后更新网页怎么办？

每次修改了 `chuyue-deploy/` 里的文件后，在 Git Bash 执行：

```bash
cd "C:/Users/USER/.qianfan/workspace/67310f27081b4b88a8fdf7f50f8cd21b/chuyue-deploy"
git add -A
git commit -m "更新网页"
git push
```

约 1 分钟后网站自动更新，无需再次设置 Pages。

---

## 常见问题

**Q：推送时要求输入用户名密码？**
输入你的 GitHub 用户名；密码位置输入 **Personal Access Token**（不是登录密码）。
获取方式：GitHub 头像 → Settings → Developer settings → Personal access tokens →
Generate new token → 勾选 `repo` → 生成后复制。
Token 只在你自己的浏览 https://github.com/settings/tokens 生成，全程不经过任何第三方。

**Q：仓库名想改别的？**
创建仓库时把 `chuyue-simulator` 换成你喜欢的英文名即可，后面脚本里填同样的名字。

**Q：页面打不开 / 404？**
- 确认仓库 Visibility 是 Public
- 确认 Pages 里 Branch 选择了 `main`
- 确认 git push 成功（脚本最后没有报错）
- 等待 1-2 分钟再刷新