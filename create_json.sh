#!/bin/bash
# 执行:   bash ./create_json.sh

# 确保当前目录名是 loganiconset
CURRENT_DIR_NAME="$(basename "$PWD")"
if [ "$CURRENT_DIR_NAME" != "loganiconset" ]; then
    echo "错误：请在 loganiconset 目录下运行此脚本."
    exit 1
fi

# 单个图片链接示例: https://raw.githubusercontent.com/loganoxo/loganiconset/master/iconset/1color/5iTV.png

ICONSET_DIR="iconset"
BASE_URL="https://ok2.1357810.xyz/loganoxo/loganiconset/master/iconset"
# BASE_URL="https://raw.githubusercontent.com/loganoxo/loganiconset/master/iconset"
ALL_JSON_FILE="all.json"
all_icons=()

echo "开始处理..."

# 清空 all.json 内容
>"$ALL_JSON_FILE"

for dir in "$ICONSET_DIR"/*/; do
    [ -d "$dir" ] || continue

    dir_name="$(basename "$dir")"
    json_file="${dir_name}.json"
    icons=()

    for img in "$dir"*; do
        [ -f "$img" ] || continue

        file_name="$(basename "$img")"
        file_url="${BASE_URL}/${dir_name}/${file_name}"

        entry="        {
            \"name\": \"${file_name}\",
            \"url\": \"${file_url}\"
        }"
        icons+=("$entry")
        all_icons+=("$entry")
    done

    {
        echo "{"
        echo "    \"name\": \"Qure Color (${dir_name})\","
        echo "    \"icons\": ["
        for i in "${!icons[@]}"; do
            if [ "$i" -lt "$((${#icons[@]} - 1))" ]; then
                echo "${icons[$i]},"
            else
                echo "${icons[$i]}"
            fi
        done
        echo "    ],"
        echo "    \"description\": \"Qure Color (${dir_name}) 是 Qure 项目下的彩色主题的「${dir_name}」图标集 @loganoxo\""
        echo "}"
    } >"$json_file"

    echo "生成: $json_file"
done

# 写入 all.json
{
    echo "{"
    echo "    \"name\": \"Qure Color (all)\","
    echo "    \"icons\": ["
    for i in "${!all_icons[@]}"; do
        if [ "$i" -lt "$((${#all_icons[@]} - 1))" ]; then
            echo "${all_icons[$i]},"
        else
            echo "${all_icons[$i]}"
        fi
    done
    echo "    ],"
    echo "    \"description\": \"Qure Color (all) 是 Qure 项目下的彩色主题的「所有」图标集 @loganoxo\""
    echo "}"
} >"$ALL_JSON_FILE"

echo "生成: $ALL_JSON_FILE"
