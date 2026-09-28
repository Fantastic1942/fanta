#!/bin/bash

check_sys_info() {
    clear
    echo -e "${GREEN}==================== 详细系统状态监控 ====================${NC}"
    if [ -f /etc/os-release ]; then
        os_name=$(source /etc/os-release && echo "$PRETTY_NAME")
    else
        os_name=$(uname -s)
    fi
    cpu_model=$(grep -m1 'model name' /proc/cpuinfo | awk -F: '{print $2}' | xargs)
    [ -z "$cpu_model" ] && cpu_model="未知 CPU"
    cpu_cores=$(nproc 2>/dev/null || echo "1")
    mem_total=$(free -h | awk '/Mem:/ {print $2}')
    mem_used=$(free -h | awk '/Mem:/ {print $3}')
    mem_free=$(free -h | awk '/Mem:/ {print $4}')
    disk_total=$(df -h / | awk 'NR==2 {print $2}')
    disk_used=$(df -h / | awk 'NR==2 {print $3}')
    disk_percent=$(df -h / | awk 'NR==2 {print $5}')
    local_ip=$(hostname -I | awk '{print $1}')
    [ -z "$local_ip" ] && local_ip="未分配"
    public_ip=$(curl -s --max-time 3 ipinfo.io/ip 2>/dev/null || echo "检测超时或无外网")
    sys_load=$(uptime | awk -F'load average:' '{print $2}')
    sys_uptime=$(uptime -p 2>/dev/null || uptime)

    echo -e "${YELLOW}[基础信息]${NC}"
    echo -e "  主机名称: $(hostname)"
    echo -e "  操作系统: $os_name"
    echo -e "  系统架构: $(uname -m)"
    echo -e "  内核版本: $(uname -r)"
    echo -e "  运行时间: $sys_uptime"
    echo -e "  系统负载:$sys_load"
    echo ""
    echo -e "${YELLOW}[硬件资源]${NC}"
    echo -e "  CPU 型号: $cpu_model"
    echo -e "  CPU 核心: $cpu_cores 核"
    echo -e "  内存状态: 已用 $mem_used / 总量 $mem_total (剩余 $mem_free)"
    echo -e "  磁盘空间: 已用 $disk_used / 总量 $disk_total (占用率 $disk_percent)"
    echo ""
    echo -e "${YELLOW}[网络状态]${NC}"
    echo -e "  内网 IP  : $local_ip"
    echo -e "  公网 IP  : $public_ip"
    echo -e "${GREEN}==========================================================${NC}"
    handle_exit_options
}

check_time() {
    clear
    echo -e "${GREEN}==================== 查看当前时间 ====================${NC}"
    echo -e "${YELLOW}> 当前服务器时间是：${NC}"
    date "+%Y年%m月%d日 %H:%M:%S"
    echo -e "${GREEN}======================================================${NC}"
    handle_exit_options
}

update_system() {
    clear
    echo -e "${GREEN}===== 正在执行全量更新系统软件 =====${NC}"
    sudo apt-get update && sudo apt-get upgrade -y
    echo -e "\n${GREEN}[完成] 执行完毕！${NC}"
    handle_exit_options
}

system_management_menu() {
    while true; do
        clear
        echo -e "${GREEN}==================== 系统状态与维护 ====================${NC}"
        echo "1. 查看系统详细信息"
        echo "2. 查看当前服务器时间"
        echo "3. 全量更新系统软件"
        echo -e "${GREEN}========================================================${NC}"
        echo ""
        read -p "请选择操作选项 [1-3] (直接回车返回上一级，输入 0 退出脚本): " sys_choice

        if [ -z "$sys_choice" ]; then
            clear
            return
        fi

        case $sys_choice in
            1)
                check_sys_info
                ;;
            2)
                check_time
                ;;
            3)
                update_system
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
