#!/usr/bin/env bash
# ============================================================
# chuyue 网页模拟器 - 一键部署脚本（在 Git Bash 中运行）
# 保存本文件到 chuyue-deploy 目录，然后执行: bash setup.sh
# ============================================================
set -e

echo "======================================"
echo "  chuyue 网页模拟器一键部署"
echo "======================================"

# 1. 检测 git
if ! command -v git >/dev/null 2>&1; then
  echo "错误: 未检测到 git，请先安装 Git for Windows。" >&2
  exit 1
fi

# 2. 检查 git 用户信息
GIT_NAME=$(git config --global user.name || true)
GIT_EMAIL=$(git config --global user.email || true)
if [ -z "$GIT_NAME" ] || [ -z "$GIT_EMAIL" ]; then
  echo "检测到尚未设置 git 全局昵称/邮箱，请先执行以下两条命令（邮箱可为任意值）："
  echo "  git config --global user.name \"你的名字\""
  echo "  git config --global user.email \"you@example.com\""
  echo "执行完以上两条后，重新运行 bash setup.sh"
  exit 1
fi

# 3. 获取 GitHub 用户名与仓库名
read -rp "请输入你的 GitHub 用户名（就是你网页链接里的那个名字）: " GH_USER
read -rp "请输入仓库名（默认 chuyue-simulator）: " REPO_NAME
REPO_NAME=${REPO_NAME:-chuyue-simulator}
GH_USER=$(echo "$GH_USER" | tr -d '[:space:]')
REPO_NAME=$(echo "$REPO_NAME" | tr -d '[:space:]')

if [ -z "$GH_USER" ]; then
  echo "错误: GitHub 用户名不能为空。" >&2
  exit 1
fi

REMOTE="https://github.com/${GH_USER}/${REPO_NAME}.git"

echo ""
echo "目标仓库: $REMOTE"
echo "------------------------"

cd "$(dirname "$0")"

# 4. 初始化仓库
if [ ! -d .git ]; then
  echo "[1/4] 初始化 git 仓库..."
  git init
else
  echo "[1/4] 已存在 .git 目录，跳过初始化"
fi

# 5. 添加文件
echo "[2/4] 添加文件到暂存区..."
git add -A

# 6. 提交
echo "[3/4] 创建提交..."
if ! git diff --cached --quiet; then
  git commit -m "chuyue 网页模拟器初始版"
else
  echo "（没有新变更，跳过提交）"
fi

# 7. 设置 main 分支并推送
echo "[4/4] 推送至 GitHub..."
git branch -M main
if git remote | grep -q origin; then
  git remote set-url origin "$REMOTE"
else
  git remote add origin "$REMOTE"
fi
git push -u origin main

echo ""
echo "======================================"
echo "  推送成功！"
echo "======================================"
echo "下一步: 前往 GitHub 仓库 Settings > Pages"
echo "  Branch 选 main, 文件夹选 / (root), 点 Save"
echo "  等待约 1 分钟后访问:"
echo "  https://${GH_USER}.github.io/${REPO_NAME}/"