#!/bin/bash

feedback_square() {
    if ! command -v python3 &> /dev/null; then
        echo -e "${YELLOW}> 准备组件 python3...${NC}"
        apt-get install -y python3 2>/dev/null || yum install -y python3 2>/dev/null
    fi

    cat << 'EOF_PY' > /tmp/fanta_board.py
import sys, json, datetime, os, codecs

try:
    if hasattr(sys.stdout, 'reconfigure'):
        sys.stdout.reconfigure(encoding='utf-8')
    else:
        sys.stdout = codecs.getwriter('utf-8')(sys.stdout.buffer, 'strict')
        sys.stderr = codecs.getwriter('utf-8')(sys.stderr.buffer, 'strict')
except Exception:
    pass

LOCAL_STORAGE = "/tmp/fanta_comments.json"

def get_data():
    if os.path.exists(LOCAL_STORAGE):
        try:
            with open(LOCAL_STORAGE, "r", encoding="utf-8") as f:
                data = json.load(f)
                if isinstance(data, dict):
                    if "requests" not in data:
                        data["requests"] = []
                    if "complaints" not in data:
                        data["complaints"] = []
                    return data
        except Exception:
            pass
    
    default_data = {
        "requests": ["[系统提示] 欢迎来到需求专区，快来提交你的第一个建议吧！"],
        "complaints": ["[系统提示] 欢迎来到吐槽专区，发现 Bug 随时吐槽~"]
    }
    save_data(default_data)
    return default_data

def save_data(data):
    try:
        with open(LOCAL_STORAGE, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        return True
    except Exception:
        return False

def display():
    try:
        data = get_data()
        reqs = data.get("requests", [])
        cmps = data.get("complaints", [])

        print("\033[1;33m============================== 需求专区 (功能建议) ==============================\033[0m")
        if not reqs:
            print("  (当前暂无需求留言)")
        else:
            for idx, item in enumerate(reqs):
                print(f"  [{idx}] {item}")
        
        print("\n\033[1;36m============================== 吐槽专区 (Bug反馈) ==============================\033[0m")
        if not cmps:
            print("  (当前暂无吐槽留言)")
        else:
            for idx, item in enumerate(cmps):
                print(f"  [{idx}] {item}")
        print("\033[0m")
    except Exception as e:
        print(f"  [显示错误] {e}")

def submit(category, contact, msg):
    data = get_data()
    if category not in data:
        data[category] = []
    now = datetime.datetime.now().strftime("%m-%d %H:%M")
    entry = f"[{now}] [{contact}]: {msg}"
    data[category].append(entry)

    if save_data(data):
        print("SUCCESS")
    else:
        print("FAILED")

def remove_entry(category, index):
    data = get_data()
    if category in data and 0 <= index < len(data[category]):
        data[category].pop(index)
        if save_data(data):
            print("SUCCESS")
            return
    print("FAILED")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        cmd = sys.argv[1]
        if cmd == "submit":
            submit(sys.argv[2], sys.argv[3], sys.argv[4])
        elif cmd == "delete":
            remove_entry(sys.argv[2], int(sys.argv[3]))
        elif cmd == "display":
            display()
        else:
            display()
    else:
        display()
EOF_PY

    while true; do
        clear
        echo -e "${GREEN}==================== 意见与交流广场 ===================${NC}\n"
        
        python3 /tmp/fanta_board.py display
        
        echo -e "\n${GREEN}=====================================================================${NC}"
        echo "1. 提交需求留言"
        echo "2. 提交吐槽留言"
        echo "3. 管理员删除留言"
        echo "4. 刷新留言广场"
        echo ""
        read -p "请输入选项 (直接回车返回上一级，输入 0 退出脚本): " fb_choice

        if [ -z "$fb_choice" ]; then
            rm -f /tmp/fanta_board.py
            clear
            return
        fi

        case $fb_choice in
            1|2)
                local type_name="需求"
                local type_key="requests"
                if [ "$fb_choice" = "2" ]; then
                    type_name="吐槽"
                    type_key="complaints"
                fi

                echo ""
                read -p "-> 请输入你的昵称/联系方式 (选填，回车默认为匿名): " user_contact
                [ -z "$user_contact" ] && user_contact="匿名用户"

                echo ""
                read -p "-> 请输入${type_name}留言内容 (必填): " user_msg
                while [ -z "$user_msg" ]; do
                    echo -e "${RED}[错误] 留言内容不能为空！${NC}"
                    read -p "-> 请输入${type_name}留言内容: " user_msg
                done

                echo -e "\n${CYAN}[处理中] 正在写入本地存储...${NC}"
                local result=$(python3 /tmp/fanta_board.py submit "$type_key" "$user_contact" "$user_msg")

                echo ""
                if [[ "$result" == *"SUCCESS"* ]]; then
                    echo -e "${GREEN}[成功] 提交成功！留言已实时保存并在面板刷新显示。${NC}"
                else
                    echo -e "${RED}[失败] 写入失败！${NC}"
                fi
                
                handle_exit_options
                ;;
            3)
                echo ""
                echo -e "${YELLOW}=== 管理员权限验证 ===${NC}"
                read -p "-> 请输入管理密码 (默认密码: admin): " admin_pass
                if [ "$admin_pass" != "admin" ]; then
                    echo -e "${RED}[错误] 密码错误，无权操作！${NC}"
                    sleep 1.5
                    continue
                fi

                echo ""
                echo "请选择要删除留言的专区："
                echo "1. 需求专区"
                echo "2. 吐槽专区"
                read -p "请输入专区编号 [1/2]: " del_zone

                local zone_key=""
                local zone_name=""
                if [ "$del_zone" = "1" ]; then
                    zone_key="requests"
                    zone_name="需求专区"
                elif [ "$del_zone" = "2" ]; then
                    zone_key="complaints"
                    zone_name="吐槽专区"
                else
                    echo -e "${RED}[错误] 无效的专区编号！${NC}"
                    sleep 1.5
                    continue
                fi

                echo ""
                echo -e "${CYAN}当前${zone_name}中的留言列表（对应编号）：${NC}"
                python3 -c "
import json, os, codecs, sys
try:
    sys.stdout = codecs.getwriter('utf-8')(sys.stdout.buffer, 'strict')
except:
    pass
p = '/tmp/fanta_comments.json'
if os.path.exists(p):
    with open(p, 'r', encoding='utf-8') as f:
        d = json.load(f)
        items = d.get('$zone_key', [])
        for idx, item in enumerate(items):
            print(f'  [{idx}] {item}')
else:
    print('  暂无留言')
"
                echo ""
                read -p "-> 请输入要删除的留言编号 (输入 -1 取消): " del_idx
                if [ "$del_idx" = "-1" ] || [ -z "$del_idx" ]; then
                    continue
                fi

                echo -e "\n${CYAN}[处理中] 正在执行删除操作...${NC}"
                local del_result=$(python3 /tmp/fanta_board.py delete "$zone_key" "$del_idx")

                echo ""
                if [[ "$del_result" == *"SUCCESS"* ]]; then
                    echo -e "${GREEN}[成功] 留言删除成功！${NC}"
                else
                    echo -e "${RED}[错误] 删除失败，请检查输入的编号是否存在！${NC}"
                fi
                
                handle_exit_options
                ;;
            4)
                continue
                ;;
            0)
                rm -f /tmp/fanta_board.py
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
