#!/bin/bash

# 변수 설정
JAR_FILE="SpringApp-0.0.1-SNAPSHOT.jar"
DEPLOY_DIR="/var/jenkins_home/appjar"
WORKSPACE_DIR="/var/jenkins_home/workspace/step02_jar_cicd/build/libs"
PORT=8999

# 디렉토리 생성 (존재하지 않을 경우)
mkdir -p "$DEPLOY_DIR"

# 이전 JAR 파일 백업
if [ -f "$DEPLOY_DIR/$JAR_FILE" ]; then
    echo "Backing up existing JAR file..."
    mv "$DEPLOY_DIR/$JAR_FILE" "$DEPLOY_DIR/${JAR_FILE}.bak"
fi

# 새로운 JAR 파일 복사
echo "Copying new JAR file..."
if cp "$WORKSPACE_DIR/$JAR_FILE" "$DEPLOY_DIR/$JAR_FILE"; then
    echo "JAR file copied successfully."
else
    echo "Failed to copy the JAR file." >&2
    exit 1
fi

# Spring Boot 애플리케이션 재시작
# 기존 포트 사용 중인 프로세스 종료
PID=$(lsof -t -i:"$PORT")
if [ -n "$PID" ]; then
    echo "Stopping existing application on port $PORT..."
    if kill "$PID"; then
        echo "Application stopped successfully."
        sleep 5
    else
        echo "Failed to stop the application." >&2
        exit 1
    fi
fi

# 백그라운드에서 새로 실행
echo "Starting new application..."
if nohup java -jar "$DEPLOY_DIR/$JAR_FILE" > "$DEPLOY_DIR/app.log" 2>&1 &; then
    echo "Application started successfully."
else
    echo "Failed to start the application." >&2
    exit 1
fi

echo "배포 완료 및 실행됩니다."
