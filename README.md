# pure-3x-ui

[![Build and Release](https://github.com/vermiliondevil-web/pure-3x-ui/actions/workflows/release.yml/badge.svg)](https://github.com/vermiliondevil-web/pure-3x-ui/actions/workflows/release.yml)
[![Sync Upstream](https://github.com/vermiliondevil-web/pure-3x-ui/actions/workflows/sync-upstream.yml/badge.svg)](https://github.com/vermiliondevil-web/pure-3x-ui/actions/workflows/sync-upstream.yml)
[![Release](https://img.shields.io/github/v/release/vermiliondevil-web/pure-3x-ui?label=release)](https://github.com/vermiliondevil-web/pure-3x-ui/releases/latest)
[![License](https://img.shields.io/github/license/vermiliondevil-web/pure-3x-ui)](LICENSE)

> **Это форк.** Проект является производной работой от [3x-ui](https://github.com/MHSanaei/3x-ui) (автор — [MHSanaei](https://github.com/MHSanaei)) и распространяется под лицензией **AGPL-3.0**. Все изменения, внесённые в этот форк, публикуются под той же лицензией.

Чистая сборка [3x-ui](https://github.com/MHSanaei/3x-ui) без рекламы и донат-блоков.

---

## О проекте

Это форк панели **3x-ui** от [MHSanaei](https://github.com/MHSanaei/3x-ui). Из файлов upstream автоматически вырезается реклама и спонсорская инфраструктура, а также исправлен баг с перезаписью ядра Xray при обновлении панели.

### Удалено из оригинала

- 🚫 Рекламные блоки в панели
- 🚫 Донат-ссылки и промо-материалы
- 🚫 Спонсорские слоты (`SponsorSlot`, `SponsorCard`, `SponsorsPage`)
- 🚫 Кнопка доната в сайдбаре (`DonateButton`)
- 🚫 Кнопка документации на сторонние ресурсы (`DocsButton`)
- 🚫 Пункт меню «Sponsors»
- 🚫 Страница `/sponsors`
- 🚫 Эндпоинт `/sponsors` в API-доках
- 🚫 Спонсорский трекинг (`sponsors.sanaei.dev`) — утечка IP и SNI

### Изменено

- 🔄 Все ссылки указывают на **этот** репозиторий (`vermiliondevil-web/pure-3x-ui`), а не на upstream
- 🔄 `panel.go`, `install.sh`, `update.sh`, `README.md` — обновлены под форк
- 🔄 **Авто-версия из тега**: `release.yml` сам подставляет номер тега в `internal/config/version`
- 🔄 **Локали не трогаются** в `remove-ads.sh` — это уменьшает diff и упрощает merge
- 🔄 **`sponsor.go` заменён на stub** — убирает утечку `sponsors.sanaei.dev`

### Исправлено

- 🔧 **Ядро Xray больше не перезаписывается при обновлении панели.**
  В upstream `update.sh` перед `tar` делает `cd /usr/local/`, поэтому
  относительный путь `bin/xray-linux-$(arch)` указывает не туда —
  архив тихо затирал ядро, выбранное пользователем через
  Settings → Xray Updates. Фикс (`scripts/remove-ads.sh`, патч `[8/8]`) —
  абсолютные пути `${xui_folder}/bin/xray-linux-$(arch)`.
  Подробности: [docs/xray-core-preservation.md](docs/xray-core-preservation.md).

- 🔧 **`release.yml` переименовывает `xray` → `xray-linux-amd64`.**
  Раньше в архиве лежал бинарник `xray`, а панель ждала
  `xray-linux-amd64` → `fork/exec bin/xray-linux-amd64: no such file
  or directory`. Теперь Xray распаковывается во временную папку и
  переименовывается перед упаковкой.

### Не изменено

Всё остальное — функциональность, Xray core, интерфейс, API, все протоколы — сохранено без изменений.

---

## Возможности

- Поддержка протоколов: **VLESS, VMess, Trojan, Shadowsocks, WireGuard, TUIC, AmneziaWG** и другие
- Мультипротокольные inbound/outbound
- Управление клиентами и лимитами трафика
- Статистика по пользователям и нодам
- Telegram-бот для управления
- Discord-уведомления
- Поддержка **PostgreSQL** и **SQLite**
- REST API + OpenAPI-спецификация
- Тёмная и светлая темы
- Поддержка **Let's Encrypt** (домен и IP)
- Fail2ban-интеграция
- Мастер-нода архитектура

---

## Установка

### Основной способ (рекомендуется)

Запустите от имени **root**:

```bash
bash <(curl -Ls https://raw.githubusercontent.com/vermiliondevil-web/pure-3x-ui/main/install.sh)
