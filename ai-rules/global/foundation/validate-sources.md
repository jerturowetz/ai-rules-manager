---
id: validate_sources
scope: global
category: reliability
description: "Always validate tool features, config formats, or APIs against authoritative and current sources before use"
tools_excluded: []
---

# Validate Sources

When referencing features, configuration files, or APIs from tools (e.g. Cursor, Warp, Copilot, ChatGPT), always **validate against at least one authoritative source** to confirm they are current and supported.

## Preferred verification sources

In order of reliability:

1. **Official documentation or product website** (e.g. `docs.cursor.com`, `docs.warp.dev`, `docs.github.com/copilot`)
2. **Release notes or changelogs** on official channels (e.g. GitHub Releases, product blog posts)
3. **Official community forums or Slack/Discord announcements** maintained by the vendor
4. **Actively maintained GitHub repositories** from the tool maintainers

## When uncertain

If you cannot verify against authoritative sources:

- Explicitly mark the information as **uncertain or possibly deprecated**
- Suggest checking the above sources directly instead of asserting as fact
- Prefer pointing to the most likely replacement feature (if identifiable) with a note that it requires confirmation

## Rationale

Many AI toolchains evolve quickly and deprecate features (e.g. `.cursorrules`). This prevents reliance on outdated or unsupported practices.