#!/usr/bin/env bash

BASE_RESOURCE_DIR="./resource"

SUCCESS_COUNT=0
FAIL_COUNT=0

CHANGE_LIST=$(git diff --cached --name-only --diff-filter=ACM -- '*.md')

if [ -z "$CHANGE_LIST" ]; then
    echo "스테이지된 마크다운 파일이 없습니다."
    exit 0
fi

for FILE in $CHANGE_LIST; do
    echo "이미지경로를 교정할 문서 파일: [$FILE]"

    RESOURCE_ID=$(sed -n 's/^resource:[[:space:]]*\(.*\)$/\1/p' "$FILE" | head -1)

    if [ -z "$RESOURCE_ID" ]; then
        echo "  [$FILE] 에 resource 메타데이터가 없습니다. 건너뜁니다."
        continue
    fi

    URLS=$(grep -oE "https://imgur\.com/[a-zA-Z0-9]{7,8}" "$FILE" | sort -u)

    if [ -z "$URLS" ]; then
        echo "  [$FILE] 에 imgur 이미지 페이지 URL이 없습니다."
        continue
    fi

    TARGET_DIR="$BASE_RESOURCE_DIR/$RESOURCE_ID"
    echo "생성할 디렉토리 경로: [$TARGET_DIR]"
    mkdir -p "$TARGET_DIR"

    for PAGE_URL in $URLS; do
        IMG_ID="${PAGE_URL##*/}"

        EXTENSIONS=("png" "jpg" "gif")
        SUCCESS=0

        for EXT in "${EXTENSIONS[@]}"; do
            DIRECT_URL="https://i.imgur.com/${IMG_ID}.${EXT}"
            FILE_NAME="${IMG_ID}.${EXT}"
            TARGET_PATH="$TARGET_DIR/$FILE_NAME"

            echo "시도하는 URL: $DIRECT_URL"
            curl -sL --fail "$DIRECT_URL" -o "$TARGET_PATH"

            if [ $? -eq 0 ] && [ -s "$TARGET_PATH" ]; then
                echo "DOWNLOAD SUCCESS: $FILE_NAME"
                REL_PATH="/resource/$RESOURCE_ID/$FILE_NAME"
                sed -i -E "s|$PAGE_URL|$REL_PATH|g" "$FILE"
                git add "$TARGET_PATH"
                SUCCESS=1
                break
            else
                rm -f "$TARGET_PATH"
            fi
        done

        if [ $SUCCESS -eq 0 ]; then
            echo "DOWNLOAD FAIL: $PAGE_URL (모든 확장자 시도 실패)"
            FAIL_COUNT=$((FAIL_COUNT+1))
        else
            SUCCESS_COUNT=$((SUCCESS_COUNT+1))
        fi
    done

    git add "$FILE"
done

printf "Success: %d, Fail: %d\n" $SUCCESS_COUNT $FAIL_COUNT
