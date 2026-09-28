#!/bin/bash

set_shortcut() {
    clear
    local script_path=$(readlink -f "$0")
    chmod +x "$script_path"
    
    echo -e "${GREEN}===== 设置系统级快捷命令 =====${NC}"
    echo -e "${YELLOW}提示：快捷命令仅支持英文字母、数字、下划线和连字符${NC}"
    echo -e "${YELLOW}⚠️ 严禁使用特殊字符（如斜杠,/、空格等），否则无法在 Linux 中生效！${NC}"
    read -p "-> 请输入您想要的快捷命令名称: " custom_cmd
    
    if [ -z "$custom_cmd" ]; then
        custom_cmd="f"
        echo -e "${YELLOW}[提示] 未输入有效名称，已自动为您设置为默认快捷键: f${NC}"
    else
        if [[ ! "$custom_cmd" =~ ^[a-zA-Z0-9_-]+$ ]]; then
            echo -e "\n${RED}[错误] 输入包含 Linux 不支持的特殊字符！${NC}"
            echo -e "${RED}[错误] 快捷命令创建失败，请重新选择字母或数字组合。${NC}"
            handle_exit_options
            return
        fi
    fi
    
    for file in /usr/local/bin/*; do
        if [ -L "$file" ] && [ "$(readlink -f "$file")" = "$script_path" ]; then
            rm -f "$file"
        fi
    done
    
    if ln -sf "$script_path" "/usr/local/bin/$custom_cmd"; then
        echo -e "\n${GREEN}[成功] 快捷命令设置成功！已即时生效。${NC}"
        echo -e "${YELLOW}以后只需在任意终端直接输入 ${GREEN}$custom_cmd${YELLOW} 即可随时启动脚本！${NC}"
    else
        echo -e "\n${RED}[错误] 软链接创建失败，请检查系统权限！${NC}"
    fi
    
    handle_exit_options
}

update_script() {
    clear
    local script_path=$(readlink -f "$0")
    echo -e "${GREEN}===== 更新脚本自身 =====${NC}"
    curl -sL -H 'Cache-Control: no-cache' "https://raw.githubusercontent.com/Fantastic1942/fanta/main/fanta.sh?v=$(date +%s)" -o "$script_path"
    chmod +x "$script_path"
    
    echo -e "\n${GREEN}[成功] 脚本已成功更新至 GitHub 最新版本！${NC}"
    echo -e "${YELLOW}提示：更新已完成，建议重新启动脚本以应用最新代码。${NC}"
    
    handle_exit_options
}

script_tool_menu() {
    while true; do
        clear
        echo -e "${GREEN}==================== 脚本与工具管理 ====================${NC}"
        echo "1. 设置快捷命令"
        echo "2. 更新脚本自身"
        echo -e "${GREEN}========================================================${NC}"
        echo ""
        read -p "请选择操作选项 [1-2] (直接回车返回上一级，输入 0 退出脚本): " tool_choice

        if [ -z "$tool_choice" ]; then
            clear
            return
        fi

        case $tool_choice in
            1)
                set_shortcut
                ;;
            2)
                update_script
                ;;
            0)
                clear
                echo -e "${GREEN}感谢使用 Fanta 工具箱，再见！${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}[错误] 输入错误！${NC}"
                sleep 1
                ;;
        esac
    done
}
