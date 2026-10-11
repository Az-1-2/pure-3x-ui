# pure-3x-ui

[![Build and Release](https://github.com/vermiliondevil-web/pure-3x-ui/actions/workflows/release.yml/badge.svg)](https://github.com/vermiliondevil-web/pure-3x-ui/actions/workflows/release.yml)
[![Sync Upstream](https://github.com/vermiliondevil-web/pure-3x-ui/actions/workflows/sync-upstream.yml/badge.svg)](https://github.com/vermiliondevil-web/pure-3x-ui/actions/workflows/sync-upstream.yml)
[![Release](https://img.shields.io/github/v/release/vermiliondevil-web/pure-3x-ui?label=release)](https://github.com/vermiliondevil-web/pure-3x-ui/releases/latest)
[![License](https://img.shields.io/github/license/vermiliondevil-web/pure-3x-ui)](LICENSE)
[![Panel Version](https://img.shields.io/github/v/release/vermiliondevil-web/pure-3x-ui?label=panel&color=blue&logo=github)](https://github.com/vermiliondevil-web/pure-3x-ui/releases/latest)
[![CDN](https://img.shields.io/badge/CDN-jsDelivr-orange?logo=cloudflare)](https://cdn.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/)
[![Cache](https://img.shields.io/badge/cache-purged%20on%20release-green?logo=githubactions)](https://github.com/vermiliondevil-web/pure-3x-ui/actions/workflows/release.yml)
[![update.sh](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/vermiliondevil-web/e8bc5a94d1f1c6d64911b342b51c05fe/raw/update-sh-status.json)](https://cdn.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/update.sh)
> **Это форк.** Проект является производной работой от [3x-ui](https://github.com/MHSanaei/3x-ui) (автор — [MHSanaei](https://github.com/MHSanaei)) и распространяется под лицензией **AGPL-3.0**. Все изменения, внесённые в этот форк, публикуются под той же лицензией.

Чистая сборка [3x-ui](https://github.com/MHSanaei/3x-ui) без рекламы и донат-блоков.

**Работает из России** — установка и обновление идут через [jsDelivr](https://www.jsdelivr.com/), потому что `raw.githubusercontent.com` блокируется РКН.

---

## ⚠️ Перед обновлением панели

Файлы `update.sh` и `install.sh` раздаются через **jsDelivr** (`cdn.jsdelivr.net`). jsDelivr кэширует файлы **до 12–24 часов** — и это может привести к тому, что панель скачает **старую версию** вместо свежей.

### 🟢 Смотрите на бейдж `update.sh`

В начале этого README есть **динамический бейдж**:

- 🟢 **`update.sh: synced`** — jsDelivr отдаёт **свежий** файл. **Можно обновляться.**
- 🔴 **`update.sh: stale`** — jsDelivr отдаёт **старую версию** из кэша. **Не обновляйтесь**, пока бейдж не станет зелёным.

Бейдж проверяется **автоматически каждые 6 часов** (GitHub Action сравнивает размер `update.sh` на GitHub raw vs jsDelivr). Когда всё синхронизировано — он зелёный. Если кэш отстал — красный.

**Как обновляться:**
1. Откройте README → проверьте бейдж `update.sh`.
2. Если **зелёный** (`synced`) — нажимайте «Обновить» в панели.
3. Если **красный** (`stale`) — подождите 30–60 секунд, обновите страницу README. Если долго остаётся красным — сбросьте кэш jsDelivr (см. ниже).

### 🛠️ Если бейдж красный долго — сбросьте кэш вручную

```bash
curl -sL "https://purge.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/update.sh"
sleep 30
curl -sL "https://cdn.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/update.sh" | wc -c
