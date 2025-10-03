---
id: tooling_parity
scope: global
category: workflow
description: "Ensure consistent behavior between command-line environment, CI/CD, and IDE"
tools_excluded: []
---

# Tooling Parity Between IDE and CLI

Ensure consistent behavior between the **command-line environment**, **CI/CD**, and the **IDE** by aligning all tooling on a single source of configuration and minimal duplication.

## Core Requirements

### 🔁 Use Shared Config

- Use one **shared config file** for any tool:
  - e.g. `phpstan.neon`, `.eslintrc.json`, `.prettierrc`, `.stylelint.config.js`
- Both the CLI and IDE **must read from this file** — no overrides, no forks

### 🧩 Recommend Extensions That Respect Config

- Recommend IDE extensions (e.g., via `.vscode/extensions.json`) that:
  - Automatically use the project's config file
  - Require minimal or no additional setup
- Example: `swordev.phpstan` extension respects `phpstan.neon` directly

### ⚙️ Minimal IDE Settings

- If needed, IDE settings (e.g., in `.vscode/settings.json`) must only enable the extension:

  ```json
  {
    "phpstan.enabled": true
  }
  ```

- Avoid duplicating rules, paths, or settings in the IDE config

## What NOT to Do

- Do **not** define separate config for the same tool in `.vscode` or global settings
- Do **not** rely on manual extension-specific settings to replicate CLI behavior
- Do **not** use tools that behave inconsistently between CLI and editor

## Goal

All contributors should see the **same output and errors**, whether they:

- Run a command like `npm run lint` or `composer analyse`
- Save a file in the IDE
- Push code through CI

No drift. No duplication. One source of truth.

## Example: WordPress + PHPStan

- CLI: `phpstan analyse` reads from `phpstan.neon`
- IDE: `swordev.phpstan` reads the same file
- IDE config:

  ```json
  {
    "phpstan.enabled": true
  }
  ```

→ Both environments behave identically. No extra maintenance required.

## Troubleshooting

If results differ between CLI and IDE, check:
- Is the IDE using the same config file?
- Are there conflicting settings in `.vscode/settings.json`?
- Is the extension outdated or not respecting the shared config?

→ If the tool or extension can't respect the shared config, consider a different one.