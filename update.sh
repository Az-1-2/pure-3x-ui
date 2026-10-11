#!/bin/bash
# pure-3x-ui updater — вызывает install.sh из нашего репозитория.

set -e

REPO="vermiliondevil-web/pure-3x-ui"
BRANCH="main"
INSTALL_URL="https://cdn.jsdelivr.net/gh/${REPO}@${BRANCH}/install.sh"

# Уникальный ID запуска — чтобы UI мог отличить этот запуск от предыдущего
export XUI_UPDATE_RUN_ID="${XUI_UPDATE_RUN_ID:-$(date +%s)-$$}"
export XUI_UPDATE_STATUS_FILE="/etc/x-ui/update-status.json"

echo "==> pure-3x-ui updater (run_id=${XUI_UPDATE_RUN_ID})"
echo "==> Скачиваем install.sh из ${REPO}..."

bash <(curl -Ls "${INSTALL_URL}")
