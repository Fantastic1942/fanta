#!/bin/bash

# ==================== 核心修复：强制切换到安全家目录 ====================
# 避免在已被删除或失效的当前工作目录下执行导致 git clone 报错
cd ~ || exit 1
# ========================================================================

# 确保脚本以 root 权限运行
if [ $EUID -ne 0 ]; then
   echo -e "\033[31m[错误] 请使用 root 权限运行此安装命令！\033[0m"
   exit 1
fi

echo -e "\033[36m[信息] 正在下载并安装 Fanta 工具箱...\033[0m"

# 如果本地已存在旧目录，先清理
rm -rf ~/fanta

# 克隆仓库到宿主机
git clone https://github.com/Fantastic1942/fanta.git ~/fanta

if [ $? -ne 0 ]; then
    echo -e "\033[31m[错误] 克隆仓库失败，请检查网络或 Git 是否安装。\033[0m"
    exit 1
fi

# 赋予主脚本及所有子模块执行权限
chmod +x ~/fanta/fanta1.sh ~/fanta/modules/*.sh 2>/dev/null

# 创建全局软链接
ln -sf ~/fanta/fanta1.sh /usr/local/bin/fanta

echo -e "\n\033[32m[成功] Fanta 工具箱安装完成！\033[0m"
echo -e "\033[33m提示：在任何地方直接输入 \033[1mfanta\033[0m\033[33m 即可启动工具箱。\033[0m"
```[cite: 4]

---

#### 2. 排查并消除换行符（CRLF）隐患的重要操作
如果你是在本地修改好代码推送到 GitHub 的，请确保文件使用的是 **LF** 换行符而不是 CRLF。
* **在服务器上直接一键修复所有脚本换行符**（最省事的办法，直接在服务器项目目录下运行一次）：
  ```bash
  cd ~/fanta && sed -i -e 's/\r$//' fanta1.sh install.sh modules/*.sh
