#!/bin/bash

# 获取真实脚本绝对路径及所在目录（完美支持软链接快捷命令）
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/modules"

# 检查 modules 目录是否存在
if [ ! -d "$MODULES_DIR" ]; then
    echo -e "\033[0;31m[错误] 找不到 modules 目录，请确保文件结构完整！\033[0m"
    exit 1
fi

# 引入所有功能模块
source "$MODULES_DIR/common.sh"
source "$MODULES_DIR/sys_mgmt.sh"
source "$MODULES_DIR/tools.sh"
source "$MODULES_DIR/vps.sh"
source "$MODULES_DIR/board.sh"

# 主菜单显示函数
show_menu() {
    clear
    echo -e "${GREEN}===== Fanta 工具箱 =====${NC}"
    echo "1. 系统状态与维护"
    echo "2. 脚本与工具管理"
    echo "3. VPS 测评与节点管理"
    echo "4. 意见与交流广场"
    echo ""
    read -p "请输入选项 [1-4] (输入 0 退出脚本): " choice
}

# 主循环控制
while true; do
    show_menu
    
    case $choice in
        1)
            system_management_menu
            ;;
        2)
            script_tool_menu
            ;;
        3)
            vps_ecosystem_menu
            ;;
        4)
            feedback_square
            ;;
        0)
            clear
            echo -e "${GREEN}感谢使用 Fanta 工具箱，再见！${NC}"
            exit 0
            ;;
        *)
            echo ""
            echo -e "${RED}[错误] 输入错误，请输入菜单中存在的数字！${NC}"
            echo ""
            read -p "按【回车键】重新输入..."
            ;;
    esac
done
