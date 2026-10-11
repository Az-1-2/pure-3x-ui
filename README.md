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

**Проверка перед обновлением** — сравните размер `update.sh`:

```bash
# Эталон (истина) — GitHub raw:
curl -sL "https://raw.githubusercontent.com/vermiliondevil-web/pure-3x-ui/main/update.sh" | wc -c

# Кэш — jsDelivr:
curl -sL "https://cdn.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/update.sh" | wc -c
```

**Что должно быть:**

| Результат | Что это значит | Что делать |
|---|---|---|
| **Размеры совпадают** (например, `1648` и `1648`) | jsDelivr отдаёт **свежий** файл ✅ | Можно обновлять |
| **Размеры разные** (например, `1648` и `361`) | jsDelivr отдаёт **старую версию** из кэша ⚠️ | Сбросить кэш — см. ниже |

**Что делать, если размеры разные** — сбросить кэш jsDelivr:

```bash
curl -sL "https://purge.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/update.sh"
sleep 30
curl -sL "https://cdn.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/update.sh" | wc -c
```

Повторяйте purge + проверку, пока размеры не совпадут. Обычно хватает 30–60 секунд.

**Автоматизация:** в `release.yml` добавлен шаг **`Purge jsDelivr cache`** — он сбрасывает кэш для `update.sh` и `install.sh` **после каждого релиза**. Если вы обновляетесь **сразу после релиза** — кэш уже сброшен. Но если релиз был давно, а вы только сейчас обновляетесь — jsDelivr мог закэшировать файл заново, и проверка нужна.

**Почему это важно:** если jsDelivr отдаёт старый `update.sh` (без `write_status`), панель не запишет `/etc/x-ui/update-status.json`, и UI покажет **«Не удалось подтвердить завершение обновления»** — даже если обновление прошло успешно. Проверка размера — самый быстрый способ убедиться, что всё в порядке.

**Пример из жизни (v3.9.5 → v3.9.6):**

- GitHub raw: `update.sh` = **1648** байт (свежий, с `write_status`).
- jsDelivr: `update.sh` = **361** байт (старый, без `write_status`).
- Результат: панель скачала старый `update.sh` → файл статуса не создался → UI показал «Не удалось подтвердить завершение обновления».
- Решение: `purge` → через 30 секунд jsDelivr начал отдавать 1648 → обновление сработало корректно.

Именно поэтому важно проверять размер **перед** обновлением.

---

## О проекте

Это форк панели **3x-ui** от [MHSanaei](https://github.com/MHSanaei/3x-ui).

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

- 🔄 Все ссылки `raw.githubusercontent.com` → `cdn.jsdelivr.net/gh/` (обход блокировки РКН)
- 🔄 `panel.go`, `install.sh`, `update.sh`, `README.md` — указывают на **этот** репозиторий
- 🔄 Автоматизация через GitHub Actions:
  - **`Sync Upstream`** — автосинхронизация с upstream (раз в день, ~17 сек)
  - **`Build and Release`** — автосборка релизов по тегу + purge jsDelivr кэша
- 🔄 **Авто-версия из тега**: `release.yml` сам подставляет номер тега в `internal/config/version`
- 🔄 **Локали не трогаются** в `remove-ads.sh` — это уменьшает diff и упрощает merge
- 🔄 **`sponsor.go` заменён на stub** — убирает утечку `sponsors.sanaei.dev` (см. раздел «Безопасность»)

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
bash <(curl -Ls https://cdn.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/install.sh)
```

Этот способ **работает из России** — скрипт скачивается через CDN jsDelivr, который не блокируется РКН.

### Альтернативные способы

Если основной способ не работает:

```bash
# 1. Через github.com/raw (редиректит на raw.githubusercontent — нужен VPN)
bash <(curl -Ls "https://github.com/vermiliondevil-web/pure-3x-ui/raw/main/install.sh")

# 2. Через jsDelivr с конкретным коммитом (обход кэша CDN)
bash <(curl -Ls https://cdn.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/install.sh)

# 3. Через jsDelivr с тегом (стабильный релиз)
bash <(curl -Ls https://cdn.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@v3.9.7/install.sh)
```

### Что делает скрипт

1. Определяет ОС и архитектуру.
2. Устанавливает зависимости.
3. Скачивает последний релиз из **этого** репозитория.
4. Проверяет `.sha256`.
5. Настраивает сервис, базу данных, SSL.
6. Выводит **логин, пароль, порт, webBasePath** и **URL** панели.

---

## Управление

```bash
x-ui              # Меню управления
x-ui start        # Запустить
x-ui stop         # Остановить
x-ui restart      # Перезапустить
x-ui status       # Статус
x-ui settings     # Текущие настройки
x-ui enable       # Включить автозапуск
x-ui disable      # Отключить автозапуск
x-ui log          # Логи
x-ui banlog       # Логи банов Fail2ban
x-ui update       # Обновить
x-ui install      # Установить
x-ui uninstall    # Удалить
```

---

## Обновление

### Через UI (кнопка «Обновить»)

Панель **сама проверяет** последний релиз на GitHub через `api.github.com/repos/vermiliondevil-web/pure-3x-ui/releases/latest` и **скачивает** `update.sh` через jsDelivr.

**Схема:**

| Версия в файле | Тег на GitHub | Кнопка |
|---|---|---|
| `3.9.6` | `v3.9.6` | ❌ неактивна |
| `3.9.6` | `v3.9.7` | ✅ активна |
| `3.9.7` | `v3.9.7` | ❌ неактивна |

**Перед обновлением** — проверьте размер `update.sh` (см. раздел «Перед обновлением панели» выше).

### Через `install.sh`

```bash
bash <(curl -Ls https://cdn.jsdelivr.net/gh/vermiliondevil-web/pure-3x-ui@main/install.sh)
```

### Xray core

Кнопка обновления Xray в панели **безопасна** — она тянет ядро напрямую с [XTLS/Xray-core](https://github.com/XTLS/Xray-core), где **нет** рекламы.

---

## Сборка из исходников

```bash
git clone https://github.com/vermiliondevil-web/pure-3x-ui.git
cd pure-3x-ui/frontend
npm install
npm run build
cd ..
CGO_ENABLED=1 GOOS=linux GOARCH=amd64 go build -ldflags "-w -s" -o x-ui-main main.go
```

Бинарник появится как `./x-ui-main`.

---

## Автоматизация

В репозитории настроены **два GitHub Actions workflow**:

### 1. `Sync Upstream` — автосинхронизация с оригиналом

**Работает ~17 секунд.** Раз в день (в 03:00 UTC) или вручную:

1. Подтягивает свежий код из [MHSanaei/3x-ui](https://github.com/MHSanaei/3x-ui).
2. **Берёт локали и `update.sh` из upstream напрямую** — чтобы избежать конфликтов.
3. Делает **коммит** этих файлов.
4. Мержит остальное с `-X theirs`.
5. Запускает `scripts/remove-ads.sh` — вырезает рекламу и заменяет `sponsor.go` на stub.
6. Коммитит изменения и пушит в `main`.

**Это значит:** когда Санаи выпускает обновление, реклама вырезается **автоматически**, а конфликтов **нет**.

### 2. `Build and Release` — сборка и публикация релизов

Запускается по тегу `v*` или вручную:

1. **`Set version from tag`** — извлекает версию из тега и записывает в `internal/config/version` и `scripts/remove-ads.sh`.
2. Вырезает рекламу (`scripts/remove-ads.sh`) — включая замену `sponsor.go` на stub.
3. Собирает фронтенд (`npm run build`).
4. Собирает Go-бинарник.
5. Скачивает Xray core с XTLS.
6. Упаковывает всё в `x-ui-linux-amd64.tar.gz` + `.sha256`.
7. Публикует релиз.
8. **`Purge jsDelivr cache`** — сбрасывает кэш для `update.sh` и `install.sh` на jsDelivr (автоматически после релиза).

### Как выпустить новую версию

1. **Создайте тег** с новым номером:

   ```bash
   cd /root/pure-3x-ui
   git pull
   git tag v3.9.8
   git push origin v3.9.8
   ```

   Или через GitHub: `Releases → Draft a new release → Choose a tag → v3.9.8 → Publish release`.

2. **GitHub Actions** сам соберёт релиз `v3.9.8` и сбросит кэш jsDelivr.

3. **Кнопка «Обновить»** станет активной.

4. **Нажмите** → панель обновится.

### Когда стоит выпускать новый релиз

- ✅ Санаи выпустил **новый стабильный релиз**.
- ✅ Накопились **важные багфиксы**.
- ✅ Вы внесли **значимые изменения**.
- ❌ **Не стоит** выпускать новый релиз на **каждый коммит** Санаи.

**Правило:** версия в `internal/config/version` **должна совпадать** с тегом.

---

## Проверка кода перед релизом

Этот форк **не является** простой копией upstream. Каждый релиз проходит проверку на предмет утечек персональных данных, телеметрии и скрытых сетевых запросов.

### Почему это важно

Оригинальный 3x-ui разрабатывается **сообществом из 310+ контрибьюторов**. Каждый PR может добавить:

- Телеметрию (отправку статистики на сторонние серверы).
- Спонсорские запросы (утечка IP и SNI).
- Сканирование окружения (проверка `.env`, `.git/config`).
- Новые зависимости с неизвестным поведением.

**Автор upstream не проверяет каждый PR** на предмет приватности. Его приоритет — функциональность и монетизация.

### Что проверяется в этом форке

| Что проверяется | Как |
|---|---|
| Спонсорский код | `scripts/remove-ads.sh` заменяет `sponsor.go` на stub |
| Рекламные ссылки | Удаляются из `AppSidebar`, `LoginPage`, `routes` |
| Телеметрия | Проверка через `strings` бинарника |
| Скрытые домены | `grep` по коду на `http://` и `https://` |
| Новые зависимости | Ручная проверка `go.mod` и `package.json` |

### Как проверить самостоятельно

```bash
# 1. Проверить, что спонсорский код удалён
grep -rn "sponsors.sanaei.dev" internal/ frontend/src/ 2>/dev/null

# 2. Проверить бинарник на подозрительные домены
strings /usr/local/x-ui/x-ui | grep -iE "sponsor|sanaei|telemetry" | head

# 3. Мониторить исходящие соединения
tcpdump -i any -n 'not host localhost' -c 20
```

### Что это значит для пользователя

- ✅ **Релевантные обновления** — подтягиваются через `Sync Upstream`.
- ✅ **Утечки** — удаляются через `remove-ads.sh` автоматически.
- ✅ **Новые фичи** — проходят проверку перед релизом.
- ⚠️ **Гарантия не 100%** — вы можете проверить код самостоятельно.

---

## Безопасность

### CVE-2026-55477: Запись произвольных файлов аутентифицированным администратором

**Что это:** В версиях 3x-ui **до 3.3.1** аутентифицированный администратор мог через импорт базы данных или редактор конфига Xray добиться **записи произвольного файла** на сервере. Манипулируя значением `xrayTemplateConfig.log.access`, злоумышленник мог перенаправить лог доступа Xray в любой файл файловой системы — включая `~/.ssh/authorized_keys`.

**Последствия:** Если Xray запущен от имени root — **полный захват сервера**.

**Оценка CVSS:** 7.2 (High).

**Затронут ли этот форк?** **Нет.** Этот форк основан на **v3.9.7**, что значительно выше исправленной версии 3.3.1.

### Устранена утечка `sponsors.sanaei.dev`

**Что было:** `internal/web/service/panel/sponsor.go` содержал жёстко прописанные URL:

```
https://sponsors.sanaei.dev/3X/sponsors.json
https://sponsors.sanaei.dev/3X/logos/
```

При каждом открытии страницы логина панель отправляла запрос на `sponsors.sanaei.dev` — раскрывая **IP сервера** и **SNI** третьей стороне. Для операторов в странах с цензурой это позволяло DPI идентифицировать панель как 3x-ui.

**Что сделано:**

- `sponsor.go` заменён на **stub** (функции возвращают пустые значения, сетевых запросов нет).
- `scripts/remove-ads.sh` **автоматически** заменяет `sponsor.go` на stub после каждого `Sync Upstream`.

**Проверка:**

```bash
strings /usr/local/x-ui/x-ui | grep -c "sponsors.sanaei.dev"
# Ожидаемо: 0
```

### Другие меры безопасности (унаследованы)

- **Ограничение IP на клиента** с интеграцией fail2ban.
- **API-токены с гранулярными областями** (SHA-256 хеши).
- **Двухфакторная аутентификация TOTP**.
- **Защита CSRF, ограничение скорости входа, защита от SSRF**.
- **Защита от path traversal** (проверено тестом `TestGeodataRejectsBadRequests`).

### Что осталось (унаследовано, не исправлено)

- **IP-адреса клиентов хранятся в открытом виде** в базе SQLite (`inbound_client_ips`, `node_client_ip`).
- **Панель сканирует своё окружение** при запуске.

### Рекомендации для операторов

1. **Обновитесь до v3.3.1+** (этот форк уже выше).
2. **Смените учётные данные администратора** сразу после установки.
3. **Ограничьте доступ к панели** доверенными IP.
4. **Запускайте Xray с минимальными привилегиями**.
5. **Включите fail2ban**.
6. **Регулярно делайте резервные копии** базы.
7. **Настройте очистку IP** (см. ниже).

---

## Рекомендация: Автоматическая очистка IP-адресов

Форк **сам по себе не решает** проблему хранения IP-адресов. Но оператор может **настроить автоматическую очистку на уровне VPS**.

### Зачем это нужно

Панель хранит IP-адреса клиентов в открытом виде в базе SQLite. Эти данные используются для:

1. Отображения активных соединений.
2. Ограничения по IP (IP Limit).

**Проблема:** если база утечёт — злоумышленник получит **реальные IP-адреса всех клиентов**.

**Почему нельзя просто отключить:**

| Способ | Проблема |
|---|---|
| Хеширование IP | Ломает IP Limit и отображение |
| Усечение IP | Оставляет провайдера |
| Полное отключение | Ломает IP Limit и fail2ban |

### Компромисс: автоматическая очистка

Скрипт `scripts/cleanup_client_ips.sh` (в репозитории) удаляет IP-записи старше 30 минут каждый час через cron.

#### Настройка на VPS

```bash
# Скопируйте скрипт из репозитория
cp /root/pure-3x-ui/scripts/cleanup_client_ips.sh /root/

# Бэкап базы
cp /etc/x-ui/x-ui.db /root/x-ui-backup-before-cleanup-$(date +%F).db

# Добавьте в cron
crontab -e
# Добавьте строку:
# 0 * * * * /root/cleanup_client_ips.sh >> /var/log/x-ui-cleanup.log 2>&1

# Проверьте
/root/cleanup_client_ips.sh
cat /var/log/x-ui-cleanup.log
```

#### Что это даёт

- ✅ Уменьшает объём исторических данных.
- ✅ Сокращает окно утечки — IP хранятся только 30 минут.
- ✅ Не ломает IP Limit и fail2ban.

#### Что это НЕ решает

- ⚠️ IP всё равно записываются на 30 минут.
- ⚠️ Это настройка VPS, не часть форка.
- ⚠️ При переустановке сервера скрипт нужно настроить заново.

---

## ⚠️ Российские VPS-провайдеры и блокировка VPN

Если вы используете российский VPS-провайдер (Timeweb, RocketCloud, Selectel, Beget, RUVDS), учтите:

### Провайдеры обязаны блокировать VPN

Согласно поправкам **«Антифрод 3.0»** (Минцифры, 2026), российские хостинг-провайдеры **обязаны**:

- Проверять клиентов по реестру Роскомнадзора.
- Отказывать в обслуживании владельцам VPN/прокси.
- Прекращать обслуживание по запросу силовых органов.

**На практике:** провайдер может фильтровать трафик через ТСПУ.

### Что делать

- **Зарубежный хостер** (Нидерланды, Германия, Финляндия).
- **Российский без цензуры**: AezaNet, VDSina, Doubleservers.
- **jsDelivr** — уже используется в `install.sh` для обхода блокировки.

---

## 🖥️ Инженерный сервер из дешёвого VPS

Не обязательно иметь мощный сервер для сборки и отладки.

### Минимальные требования

| Ресурс | Минимум | Рекомендую |
|---|---|---|
| RAM | 1 ГБ | 2 ГБ |
| Swap | 2 ГБ | 2 ГБ |
| Диск | 10 ГБ | 20 ГБ |
| CPU | 1 ядро | 2 ядра |

### Альтернатива: GitHub Codespaces

Вместо инженерного VPS можно использовать **GitHub Codespaces**:

- **60 часов/мес бесплатно**.
- Ubuntu + Go + Node из коробки.
- Работает в браузере.
- `remove-ads.sh` — **0.7 сек**.
- `npm install` — 2 мин.
- `go build` — 3 мин.

**Экономия:** ~1188₽/год, если удалить инженерный VPS.

---

## Происхождение и лицензия

### Это форк

`pure-3x-ui` — производная работа (форк) от [3x-ui](https://github.com/MHSanaei/3x-ui).

- Проект **не является** оригинальной разработкой.
- Основа — код [MHSanaei/3x-ui](https://github.com/MHSanaei/3x-ui).
- Все изменения — надстройка над оригиналом.
- Оригинальный автор **не несёт ответственности** за этот форк.

### Лицензия AGPL-3.0

Проект распространяется под лицензией **GNU Affero General Public License v3.0** (AGPL-3.0).

**Что это значит:**

- ✅ Можно использовать, изменять, распространять.
- ✅ Можно делать форки.
- ⚠️ Обязательно сохранять ту же лицензию (AGPL-3.0).
- ⚠️ Обязательно указывать автора оригинала.
- ⚠️ Если вы даёте доступ к панели по сети — вы обязаны предоставить исходный код.
- ⚠️ Нельзя делать закрытые форки.

### Ссылки

- **Оригинал:** https://github.com/MHSanaei/3x-ui
- **Этот форк:** https://github.com/vermiliondevil-web/pure-3x-ui
- **Текст лицензии:** [LICENSE](LICENSE)

---

## Благодарности

- [MHSanaei](https://github.com/MHSanaei) — за оригинальный 3x-ui
- [XTLS/Xray-core](https://github.com/XTLS/Xray-core) — за ядро Xray
- [Acme.sh](https://github.com/acmesh-official/acme.sh) — за SSL-сертификаты
- [jsDelivr](https://www.jsdelivr.com/) — за CDN, работающий из РФ
- Всем контрибьюторам оригинального проекта

---

## Обратная связь

- Issues: https://github.com/vermiliondevil-web/pure-3x-ui/issues
- Pull Requests: приветствуются

---

## Дисклеймер

Это **неофициальный форк**. Проект не связан с MHSanaei или XTLS.

Панель предоставляется как есть, для личного и некоммерческого использования.
