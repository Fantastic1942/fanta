#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

handle_exit_options() {
    echo ""
    echo -e "${CYAN}----------------------------------------------------------${NC}"
    read -p "按【回车键】返回上一级菜单 (输入 0 退出脚本): " sub_choice
    if [ "$sub_choice" = "0" ]; then
        clear
        echo -e "${GREEN}感谢使用 Fanta 工具箱，再见！${NC}"
        exit 0
    fi
}
