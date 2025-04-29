@echo off
REM github에 올린 user-images를 자동으로 다운로드합니다.

setlocal enabledelayedexpansion

set NUM=1855714
set SUCCESS_COUNT=0
set FAIL_COUNT=0

REM 변경된 .md 파일 목록 가져오기
for /f "delims=" %%i in ('git diff --exit-code --cached --name-only --diff-filter=ACM -- "*.md"') do (

    set "CHANGED_FILE=%%i"
    echo 이미지 경로를 교정할 문서 파일: [!CHANGED_FILE!]

    REM 파일 맨 위에서 폴더 경로 추출 (정규표현식 불가. 여기선 RESOURCE_DIR 직접 입력하거나 패스)
    set "RESOURCE_DIR="
    for /f "tokens=*" %%r in ('findstr /R "[A-F0-9][A-F0-9]/[A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-][A-F0-9-]" !CHANGED_FILE!') do (
        set "RESOURCE_DIR=%%r"
    )

    set "TARGET_PATH=.\resource\!RESOURCE_DIR!"
    echo 생성할 디렉토리 경로: [!TARGET_PATH!]
    mkdir "!TARGET_PATH!" 2>nul

    REM URI 목록 찾기 (트위터나 user-images 링크 찾기)
    for /f "delims=" %%u in ('findstr /R "https://\(user-images\.githubuser.*?/%NUM%/\|pbs\.twimg\.com/media/\|video\.twimg\.com/.+_video/\).*\(png\|jpg\|gif\|mp4\)" !CHANGED_FILE!') do (

        set "URI=%%u"
        for %%a in (!URI!) do set "FILE_NAME=%%~nxa"
        set "RESOLVE_FILE_PATH=!TARGET_PATH!\!FILE_NAME!"
        set "RESOLVE_URL=!RESOLVE_FILE_PATH:~1!"

        echo 작업 대상 URI: [!URI!]
        echo 작업 대상 파일 패스: [!RESOLVE_FILE_PATH!]
        curl -s -o "!RESOLVE_FILE_PATH!" "!URI!"

        if !errorlevel! == 0 (
            echo DOWNLOAD SUCCESS: !FILE_NAME!
            powershell -Command "(Get-Content -Raw '!CHANGED_FILE!').Replace('!URI!', '!RESOLVE_URL!') | Set-Content '!CHANGED_FILE!'"
            git add "!RESOLVE_FILE_PATH!"
            set /a SUCCESS_COUNT+=1
        ) else (
            echo DOWNLOAD FAIL: !FILE_NAME!
            del /f /q "!RESOLVE_FILE_PATH!"
            set /a FAIL_COUNT+=1
        )
    )

    git add "!CHANGED_FILE!"
)

echo Success: %SUCCESS_COUNT%, Fail: %FAIL_COUNT%
exit /b
