#!/bin/bash
# pure-3x-ui updater — вызывает install.sh из нашего репозитория.
# Пишет статус в $XUI_UPDATE_STATUS_FILE для GetUpdateStatus() в panel.go.

set -e

REPO="vermiliondevil-web/pure-3x-ui"
BRANCH="main"
INSTALL_URL="https://cdn.jsdelivr.net/gh/${REPO}@${BRANCH}/install.sh"

# Значения по умолчанию — если panel.go их не передал
: "${XUI_UPDATE_RUN_ID:=$(date +%s%N)}"
: "${XUI_UPDATE_STATUS_FILE:=/etc/x-ui/update-status.json}"

# Функция записи статуса — совместима с PanelUpdateStatus в panel.go
write_status() {
    local state="$1"
    local exit_code="${2:-0}"
    local finished_at
    finished_at=$(date +%s)
    install -d -m 700 "$(dirname "$XUI_UPDATE_STATUS_FILE")" 2>/dev/null || true
    umask 077
    cat > "$XUI_UPDATE_STATUS_FILE" <<JSONEOF
{"runId":"${XUI_UPDATE_RUN_ID}","state":"${state}","exitCode":${exit_code},"finishedAt":${finished_at}}
JSONEOF
    chmod 600 "$XUI_UPDATE_STATUS_FILE" 2>/dev/null || true
}

# Ловим любой выход — как в оригинальном update.sh Санаи (см. комментарий panel.go:196)
trap 'rc=$?; if [ "$rc" -eq 0 ]; then write_status success 0; else write_status failed "$rc"; fi' EXIT

echo "==> pure-3x-ui updater (run_id=${XUI_UPDATE_RUN_ID})"
echo "==> Скачиваем install.sh из ${REPO}..."

# Запускаем install.sh. Он делает всю работу.
# trap EXIT выше запишет итог, когда скрипт завершится (успешно или нет).
bash <(curl -Ls "${INSTALL_URL}")
