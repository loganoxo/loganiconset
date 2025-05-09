#!/bin/bash

ICONSET_DIR="iconset"
GITHUB_BASE_URL="https://raw.githubusercontent.com/loganoxo/Qure/master/IconSet/Color"
ALL_JSON_FILE="all.json"

echo "[" >"$ALL_JSON_FILE"
first_group=true

for dir in "$ICONSET_DIR"/*/; do
    [ -d "$dir" ] || continue

    dir_name="$(basename "$dir")"
    json_file="${dir_name}.json"
    group_json=""
    first=true

    group_json+="  {\n"
    group_json+="    \"name\": \"${dir_name//\"/\\\"}\",\n"
    group_json+="    \"icons\": [\n"

    for img in "$dir"*; do
        [ -f "$img" ] || continue

        file_name="$(basename "$img")"
        file_url="${GITHUB_BASE_URL}/${dir_name}/${file_name}"
        file_name_escaped="${file_name//\"/\\\"}"

        if $first; then
            first=false
        else
            group_json+=",\n"
        fi

        group_json+="      {\"name\": \"${file_name_escaped}\", \"url\": \"${file_url}\"}"
    done

    group_json+="\n    ],\n"
    group_json+="    \"description\": \"${dir_name//\"/\\\"} 是 Qure 项目下的彩色主题的「禁止」图标集 @loganoxo\"\n"
    group_json+="  }"

    echo -e "{\n${group_json:2}\n}" >"${dir_name}.json"
    echo "生成: ${dir_name}.json"

    if $first_group; then
        first_group=false
    else
        echo "," >>"$ALL_JSON_FILE"
    fi

    echo -e "$group_json" >>"$ALL_JSON_FILE"
done

echo -e "\n]" >>"$ALL_JSON_FILE"
echo "生成: $ALL_JSON_FILE"
