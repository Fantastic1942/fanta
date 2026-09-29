#!/bin/bash

vps_merchants() {
    clear
    echo -e "${GREEN}==================== 常用 VPS 商家导航 ====================${NC}"
    echo -e "${CYAN}1. RackNerd${NC}"
    echo -e "   特点: 性价比极高、年付便宜、适合新手折腾美国入门小鸡"
    echo -e "   网址: https://www.racknerd.com"
    echo ""
    echo -e "${CYAN}2. BandwagonHost (搬瓦工)${NC}"
    echo -e "   特点: 线路优质（CN2 GIA）、高端稳定、适合对网络质量要求高的用户"
    echo -e "   网址: https://bandwagonhost.com"
    echo ""
    echo -e "${CYAN}3. DMIT${NC}"
    echo -e "   特点: 洛杉矶与香港 CN2 GIA 高端线路、大带宽、适合建站与高速需求"
    echo -e "   网址: https://www.dmit.io"
    echo ""
    echo -e "${CYAN}4. Vultr / DigitalOcean${NC}"
    echo -e "   特点: 全球多机房、按小时计费、主流云服务商"
    echo -e "   网址: https://www.vultr.com"
    echo ""
    echo -e "${CYAN}5. CloudSilk${NC}"
    echo -e "   特点: 专营美西、港日韩等优化线路小鸡、速度优秀"
    echo -e "   网址: https://cloudsilk.io"
    echo ""
    echo -e "${CYAN}6. CloudCone${NC}"
    echo -e "   特点: 洛杉矶超低价年付/月付小鸡、适合备用与轻量应用"
    echo -e "   网址: https://cloudcone.com"
    echo ""
    echo -e "${CYAN}7. VMISS${NC}"
    echo -e "   特点: 主打香港、日本、韩国等亚洲优质网络线路、延迟低"
    echo -e "   网址: https://vmiss.com"
    echo ""
    echo -e "${CYAN}8. ZGOcloud${NC}"
    echo -e "   特点: 以大硬盘、高性价比及高性能节点受到欢迎"
    echo -e "   网址: https://zgocloud.com"
    echo ""
    echo -e "${CYAN}9. VMRack${NC}"
    echo -e "   特点: 提供稳定且价格适中的虚拟服务器选择"
    echo -e "   网址: https://vmrack.net"
    echo -e "${GREEN}==========================================================${NC}"
    handle_exit_options
}

vps_players_community() {
    clear
    echo -e "${GREEN}==================== 优秀的 VPS 玩家与社区 ====================${NC}"
    echo -e "${CYAN}1. NodeSeek 社区${NC}"
    echo -e "   简介: 国内目前最火热的 VPS 评测、技术交流与羊毛分享论坛"
    echo -e "   网址: https://www.nodeseek.com"
    echo ""
    echo -e "${CYAN}2. HostLoc 论坛${NC}"
    echo -e "   简介: 老牌经典的 VPS 玩家交流聚集地"
    echo -e "   网址: https://hostloc.com"
    echo ""
    echo -e "${CYAN}3. DigVPS${NC}"
    echo -e "   简介: 专注于 VPS 评测、网络性能测试和商家优惠信息聚合的专业站点"
    echo -e "   网址: https://digvps.com"
    echo ""
    echo -e "${CYAN}4. 不良林 (Bulianglin)${NC}"
    echo -e "   简介: 深入浅出的科学上网、VPS 搭建和网络优化教程"
    echo -e "   网址: https://bulianglin.com"
    echo ""
    echo -e "${CYAN}5. 零度解说 (FreeDidi)${NC}"
    echo -e "   简介: 长期分享各类免费 VPS、薅羊毛资讯及便宜服务器优惠信息"
    echo -e "   网址: https://freedidi.com"
    echo ""
    echo -e "${CYAN}6. Kejilion 博客/工具箱${NC}"
    echo -e "   简介: 优秀的 Linux 运维与实用工具箱开发者"    
    echo -e "   网址: https://kejilion.pro"
    echo ""
    echo -e "${CYAN}7. Porter科技迷 (Potoh - 优秀VPS博客)${NC}"
    echo -e "   简介: WARP 一键配置脚本与网络优化专家"
    echo -e "   网址: https://potoh.com/"
    echo -e "${GREEN}==========================================================${NC}"
    handle_exit_options
}

vps_ecosystem_menu() {
    while true; do
        clear
        echo -e "${GREEN}==================== VPS 测评与节点管理 ====================${NC}"
        echo -e "${YELLOW}--- 性能与网络测评 ---${NC}"
        echo "1. 快捷三网回程测试"
        echo "2. NodeQuality 融合怪测评"
        echo "3. 经典 VPS 融合怪全面测评"
        echo -e "${YELLOW}--- 节点快捷搭建 ---${NC}"
        echo "4. 3x-ui 多协议可视化面板"
        echo "5. 甬哥 Sing-box 精装桶五合一脚本"
        echo "6. Kejilion Linux 综合运维与节点工具箱"
        echo "7. fscarmen WARP 一键配置脚本"
        echo "8. Litebox 轻量 Sing-box 节点脚本"
        echo "9. fscarmen sing-box 一键脚本"
        echo -e "${YELLOW}--- 玩家推荐与导航 ---${NC}"
        echo "10. 常用 VPS 商家导航"
        echo "11. 优秀的 VPS 玩家与社区"
        echo -e "${GREEN}================================================================${NC}"
        echo ""
        read -p "请选择操作选项 [1-11] (直接回车返回上一级，输入 0 退出脚本): " vps_choice

        if [ -z "$vps_choice" ]; then
            clear
            return
        fi

        case $vps_choice in
            1)
                clear
                echo -e "${GREEN}===== 快捷三网回程测试 =====${NC}"
                if ! command -v curl &> /dev/null; then
                    apt-get install -y curl 2>/dev/null || yum install -y curl 2>/dev/null
                fi
                curl -sL https://raw.githubusercontent.com/zhanghanyun/backtrace/main/install.sh | bash
                handle_exit_options
                ;;
            2)
                clear
                echo -e "${GREEN}===== 正在启动 NodeQuality 融合怪测评... =====${NC}"
                bash <(curl -sL https://run.NodeQuality.com)
                handle_exit_options
                ;;
            3)
                clear
                echo -e "${GREEN}===== 正在启动经典 VPS 融合怪全面测评 (ecs.sh)... =====${NC}"
                bash <(curl -L https://github.com/spiritLHLS/ecs/raw/main/ecs.sh)
                handle_exit_options
                ;;
            4)
                clear
                echo -e "${GREEN}===== 正在安装 3x-ui 面板 =====${NC}"
                bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
                handle_exit_options
                ;;
            5)
                clear
                echo -e "${GREEN}===== 正在安装甬哥 Sing-box 五合一脚本 =====${NC}"
                bash <(curl -sL https://raw.githubusercontent.com/yonggekkk/sing-box-yg/main/sb.sh)
                handle_exit_options
                ;;
            6)
                clear
                echo -e "${GREEN}===== 正在安装 Kejilion Linux 工具箱 =====${NC}"
                bash <(curl -sS https://raw.githubusercontent.com/kejilion/sh/main/kejilion.sh)
                handle_exit_options
                ;;
            7)
                clear
                echo -e "${GREEN}===== 正在运行 fscarmen WARP 脚本 =====${NC}"
                bash <(curl -sL https://gitlab.com/fscarmen/warp/-/raw/main/warp.sh)
                handle_exit_options
                ;;
            8)
                clear
                echo -e "${GREEN}===== 正在运行 Litebox 轻量 Sing-box 节点脚本 =====${NC}"
                bash <(curl -fsSL https://raw.githubusercontent.com/linlvyy/litebox-singbox-mini/main/install.sh)
                handle_exit_options
                ;;
            9)
                clear
                echo -e "${GREEN}===== 正在运行 fscarmen sing-box 脚本 =====${NC}"
                bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh)
                handle_exit_options
                ;;
            10)
                vps_merchants
                ;;
            11)
                vps_players_community
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
