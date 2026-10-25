# Xray Core Preservation on Panel Update

## Problem

`update.sh` (upstream 3x-ui logic) does:

    cd ${xui_folder%/x-ui}/    # → /usr/local/
    ...
    tar zxvf x-ui-linux-$(arch).tar.gz
    cd x-ui                    # → /usr/local/x-ui/

Before `tar`, the working directory is `/usr/local/`, not
`/usr/local/x-ui/`. Any relative path `bin/xray-linux-$(arch)` resolves
to `/usr/local/bin/xray-linux-amd64`, which does not exist.

Result: the [8/8] save/restore block did not find the user-selected
Xray core, and the archive silently overwrote it with the bundled
version on every panel update.

## Fix

`scripts/remove-ads.sh` patches `update.sh` so the save/restore block
uses absolute paths:

    ${xui_folder}/bin/xray-linux-$(arch)

Both in update.sh and in the remove-ads.sh patcher itself, to prevent
regression on future Sync Upstream.

Commit: 5c79abcf

## Verification

Verified 2026-10-12 on production (root@393920):

- Panel: 3.9.21 → 3.9.22 via web UI
- Xray core before: 26.9.30 (user-selected via UI)
- Xray core after: 26.9.30 (preserved)
- stat bin/xray-linux-amd64:
  Modify: 2026-10-12 21:29:27 (matches update moment)
  Change: 2026-10-12 21:29:27

The Modify timestamp matching the update moment proves the patch
restored the saved core after tar extraction (otherwise the file
would not have been touched, or would show the archive's timestamp
and version).

## How to re-check after a future update

    stat /usr/local/x-ui/bin/xray-linux-amd64 | grep Modify
    /usr/local/x-ui/bin/xray-linux-amd64 -version | head -1

If Modify matches the update time and version is what you selected —
patch works. If version is the archive's bundled version — patch
regressed; re-run scripts/remove-ads.sh and verify:

    grep -n 'xui_folder}/bin/xray-linux' update.sh

Expected: 3 lines.
