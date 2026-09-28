#!/bin/bash
# 确保脚本以 root 权限运行
if [ $EUID -ne 0 ]; then echo -e "\033[31m[错误] 请使用 root 权限运行此安装命令！\033[0m" exit 1 fi echo -e "\033[36m[信息] 正在下载并安装 Fanta 工具箱...\033[0m"
# 如果本地已存在旧目录，先清理
rm -rf ~/fanta
# 克隆仓库到宿主机
git clone https://github.com/Fantastic1942/fanta.git ~/fanta if [ $? -ne 0 ]; then echo -e "\033[31m[错误] 克隆仓库失败，请检查网络或 Git 是否安装。\033[0m" exit 1 fi
# 赋予主脚本执行权限
chmod +x ~/fanta/fanta1.sh
# 创建全局软链接
ln -sf ~/fanta/fanta1.sh /usr/local/bin/fanta echo -e "\033[32m[成功] Fanta 工具箱安装完成！\033[0m"
echo -e "\033[33m提示：在任何地方直接输入 \033[1mfanta\033[0m\033[33m 即可启动工具箱。\033[0m"
