# #!/usr/bin/env bash

# # github에 올린 user-images를 자동으로 다운로드합니다.

# NUM=1855714

# CHANGE_LIST=`git diff --exit-code --cached --name-only --diff-filter=ACM -- '*.md'`

# SUCCESS_COUNT=0
# FAIL_COUNT=0
# for CHANGED_FILE in $CHANGE_LIST; do
#     echo "이미지경로를 교정할 문서 파일: [$CHANGED_FILE]"

#     RESOURCE_DIR=`head $CHANGED_FILE | egrep -o '[A-F0-9-]{2}/[A-F0-9-]{34}$'`
#     TARGET_PATH="./resource/$RESOURCE_DIR"

#     echo "생성할 디렉토리 경로: [$TARGET_PATH]"
#     mkdir -p $TARGET_PATH

#     # 작업 대상 파일에서 참조하고 있는 github에 등록된 리소스 파일들의 URI 목록
#     # URI_LIST=`ag "https://user-images\.githubuser.*?\/$NUM\/.*?(png|jpg|gif|mp4)" -o $CHANGED_FILE`
#     # URI_LIST=`ag "https://pbs.twimg.com/media/.*?(png|jpg|gif|mp4)" -o $CHANGED_FILE`

#     URI_LIST=`ag "https://((user-images\.githubuser.*?\/$NUM\/)|(pbs.twimg.com/media/)|(video.twimg.com/.+_video/)).*?(png|jpg|gif|mp4)" -o $CHANGED_FILE`

#     for URI in $URI_LIST; do
#         FILE_NAME=`echo $URI | sed 's,^.*/,,'`
#         RESOLVE_FILE_PATH="$TARGET_PATH/$FILE_NAME"
#         RESOLVE_URL=`echo "$RESOLVE_FILE_PATH" | sed -E 's/^\.//'`

#         echo "작업 대상 URI: [$URI]"
#         echo "작업 대상 파일 패스: [$RESOLVE_FILE_PATH]"
#         curl -s $URI > $RESOLVE_FILE_PATH

#         if [ "$?" == "0" ]; then
#             echo "DOWNLOAD SUCCESS: $FILE_NAME"
#             sed -i '' -E 's, *https://.*('"$FILE_NAME"') *, '$RESOLVE_URL' ,g' $CHANGED_FILE

#             git add $RESOLVE_FILE_PATH

#             SUCCESS_COUNT=$((SUCCESS_COUNT+1))
#         else
#             echo "DOWNLOAD FAIL: $FILE_NAME"
#             rm -f $RESOLVE_FILE_PATH
#             FAIL_COUNT=$((FAIL_COUNT+1))
#         fi
#     done
#     git add $CHANGED_FILE
# done

# printf "Success: %d, Fail: %d\n" $SUCCESS_COUNT $FAIL_COUNT



# imgur
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

    TARGET_DIR="$BASE_RESOURCE_DIR/$RESOURCE_ID"
    echo "생성할 디렉토리 경로: [$TARGET_DIR]"
    mkdir -p "$TARGET_DIR"

    URLS=$(grep -oE "https://imgur\.com/[a-zA-Z0-9]{7,8}(?!\.(jpg|png|gif))" "$FILE" | sort -u)

    if [ -z "$URLS" ]; then
        echo "  [$FILE] 에 imgur 이미지 페이지 URL이 없습니다."
        continue
    fi

    for PAGE_URL in $URLS; do
        IMG_ID="${PAGE_URL##*/}"

        echo "작업 대상 URI: [$PAGE_URL]"

        DIRECT_URL=$(curl -sL "$PAGE_URL" | grep -oP '(?<=property="og:image" content=")[^"]+')

        if [ -z "$DIRECT_URL" ]; then
            echo "DOWNLOAD FAIL: [$PAGE_URL] 에서 이미지 URL을 찾을 수 없습니다."
            FAIL_COUNT=$((FAIL_COUNT+1))
            continue
        fi

        FILE_NAME=$(basename "$DIRECT_URL")
        TARGET_PATH="$TARGET_DIR/$FILE_NAME"

        echo "작업 대상 파일 패스: [$TARGET_PATH]"
        curl -sL "$DIRECT_URL" -o "$TARGET_PATH"

        if [ $? -eq 0 ] && [ -s "$TARGET_PATH" ]; then
            echo "DOWNLOAD SUCCESS: $FILE_NAME"
            REL_PATH="./resource/$RESOURCE_ID/$FILE_NAME"

            # Windows Git Bash / Linux 용 sed (in-place)
            sed -i -E "s|$PAGE_URL|$REL_PATH|g" "$FILE"

            git add "$TARGET_PATH"
            SUCCESS_COUNT=$((SUCCESS_COUNT+1))
        else
            echo "DOWNLOAD FAIL: $FILE_NAME"
            rm -f "$TARGET_PATH"
            FAIL_COUNT=$((FAIL_COUNT+1))
        fi
    done

    git add "$FILE"
done

printf "Success: %d, Fail: %d\n" $SUCCESS_COUNT $FAIL_COUNT