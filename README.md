<div align="center">

# ⚡ claude-code-deepseek

**Run Claude Code CLI on DeepSeek's Anthropic-compatible API**<br>
Built for security researchers & bug bounty hunters

<br>

```bash
$ claude-ds

  Claude Code v2.1.166
  deepseek-v4-pro with high effort · API Usage Billing
  /home/user

❯ Try "how does <filepath> work?"
```

<br>

![DeepSeek](https://img.shields.io/badge/DeepSeek-v4--pro-blue?style=for-the-badge)
![Claude Code](https://img.shields.io/badge/Claude_Code-2.x-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Stars](https://img.shields.io/github/stars/0x-elfateh1/claude-code-deepseek?style=for-the-badge&color=gold)

<br>

![Cost](https://img.shields.io/badge/~%246_per_350M_tokens-💸-yellow?style=flat-square)
![Shell](https://img.shields.io/badge/zsh%20%7C%20bash%20%7C%20powershell-supported-blueviolet?style=flat-square)
![Topics](https://img.shields.io/badge/security--research-bug--bounty-red?style=flat-square)

</div>

---

## 🚀 At a Glance

| | Detail |
|---|---|
| 🧠 **Main model** | `deepseek-v4-pro` — heavy reasoning, main agent |
| ⚡ **Subagent model** | `deepseek-v4-flash` — fast & cheap for background tasks |
| 💸 **Cost** | ~$6 per 350M tokens |
| 🔓 **Headless** | API key works on VPS — no browser OAuth needed |
| 🔄 **Revertable** | One `unset` command back to Anthropic subscription |
| 🖥️ **Platforms** | Linux, macOS, Windows, VPS |

---

## 📋 Table of Contents

- [Why DeepSeek?](#-why-deepseek)
- [Model IDs](#-model-ids)
- [Quick Setup](#-quick-setup)
- [Setup Methods](#-setup-methods)
  - [Method 1 — Global](#method-1--global-all-deepseek-always)
  - [Method 2 — Per-Project](#method-2--per-project-selective)
  - [Method 3 — Shell Function ⭐](#method-3--shell-function-per-session-)
  - [Method 4 — Automation / CI](#method-4--automation--ci)
- [Reverting to Anthropic](#-reverting-to-anthropic-subscription)
- [Key Notes](#-key-notes)
- [Files](#-files)
- [Author](#-author)

---

## 💡 Why DeepSeek?

> **Strategy:** Keep your Claude subscription for interactive daily coding. Use DeepSeek API for VPS automation, CI pipelines, and heavy subagent workloads where rate limits and OAuth get in the way.

| | Anthropic Subscription | DeepSeek API |
|---|:---:|:---:|
| Interactive coding | ✅ Best | ✅ Good |
| Headless / VPS automation | ❌ Needs OAuth login | ✅ Just an API key |
| Rate limits | Subscription caps | Pay-per-token, no hard caps |
| Cost at scale | Fixed monthly fee | ~$6 per 350M tokens |
| Subagent heavy workloads | Burns through quota | Cheap with `v4-flash` |
| CI / cron pipelines | Auth issues | ✅ Works cleanly |

---

## 🔑 Model IDs

| Model | ID | Best For |
|---|---|---|
| 🧠 Flagship | `deepseek-v4-pro` | Main agent, complex reasoning, security analysis |
| ⚡ Fast | `deepseek-v4-flash` | Subagents, background tasks, file search, quick Q&A |

> ⚠️ **Deprecation notice:** `deepseek-chat` and `deepseek-reasoner` are deprecated **July 24 2026**. Use the IDs above.

**Auto-mapping:** DeepSeek maps Claude model names automatically:
- `claude-opus-*` → `deepseek-v4-pro`
- `claude-haiku-*` / `claude-sonnet-*` → `deepseek-v4-flash`

---

## ⚡ Quick Setup

Full config from [DeepSeek's official docs](https://api-docs.deepseek.com/guides/coding_agents):

```bash
export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
export ANTHROPIC_AUTH_TOKEN=<your_deepseek_key>
export ANTHROPIC_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash
export CLAUDE_CODE_SUBAGENT_MODEL=deepseek-v4-flash
export CLAUDE_CODE_EFFORT_LEVEL=max
```

> Get your API key at [platform.deepseek.com](https://platform.deepseek.com) — use `ANTHROPIC_AUTH_TOKEN`, **not** `ANTHROPIC_API_KEY`.

Ready-to-use config snippets in [`configs/`](./configs/).

---

## 🛠 Setup Methods

### Method 1 — Global (All DeepSeek, Always)

Best if you want DeepSeek for all Claude Code sessions everywhere.

Add to `~/.zshrc` or `~/.bashrc`:

```bash
export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
export ANTHROPIC_AUTH_TOKEN=<your_deepseek_key>
export ANTHROPIC_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash
export CLAUDE_CODE_SUBAGENT_MODEL=deepseek-v4-flash
export CLAUDE_CODE_EFFORT_LEVEL=max
```

Then reload: `source ~/.zshrc`

---

### Method 2 — Per-Project (Selective)

Best if you want DeepSeek only inside specific project folders. Every other directory keeps using your Anthropic subscription normally.

Create `.claude/settings.json` inside the project:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.deepseek.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "<your_deepseek_key>",
    "ANTHROPIC_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "deepseek-v4-pro",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "deepseek-v4-flash",
    "CLAUDE_CODE_SUBAGENT_MODEL": "deepseek-v4-flash"
  }
}
```

See [`configs/settings.json`](./configs/settings.json) for a ready-to-use template.

---

### Method 3 — Shell Function (Per-Session) ⭐

**Recommended.** Keep `claude` on your Anthropic subscription. Use `claude-ds` when you want DeepSeek. Switch per terminal session with zero config touching.

> ⚠️ Use a **shell function**, not an alias — multi-line aliases are fragile in zsh.

Add to `~/.zshrc`:

```bash
claude-ds() {
  ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic" \
  ANTHROPIC_AUTH_TOKEN="<your_deepseek_key>" \
  ANTHROPIC_MODEL="deepseek-v4-pro" \
  ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro" \
  ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro" \
  ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-flash" \
  CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash" \
  claude "$@"
}
```

Then reload: `source ~/.zshrc`

| Command | Result |
|---|---|
| `claude` | Anthropic subscription — unchanged |
| `claude-ds` | DeepSeek session |
| `claude-ds -p "audit this file"` | Passes all flags/args through correctly |

---

### Method 4 — Automation / CI

Best for headless VPS runs, cron jobs, CI pipelines. No global config needed — set vars inline per script.

```bash
ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic" \
ANTHROPIC_AUTH_TOKEN="<your_deepseek_key>" \
ANTHROPIC_MODEL="deepseek-v4-pro" \
CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash" \
claude --dangerously-skip-permissions -p "your task here"
```

Your Anthropic subscription remains untouched in every other terminal.

---

## 🔄 Reverting to Anthropic Subscription

No API key needed — just unset the DeepSeek vars. Claude Code falls back to your subscription OAuth session stored in `~/.claude/` automatically.

**Temp revert (current terminal only):**

```bash
unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_MODEL \
      ANTHROPIC_DEFAULT_OPUS_MODEL ANTHROPIC_DEFAULT_SONNET_MODEL \
      ANTHROPIC_DEFAULT_HAIKU_MODEL CLAUDE_CODE_SUBAGENT_MODEL \
      CLAUDE_CODE_EFFORT_LEVEL
```

**Permanent revert:** remove the export lines from `~/.zshrc` / `~/.bashrc`, then `source` the file.

If you used `.claude/settings.json` — delete the file or remove the `env` block.

---

## 📌 Key Notes

- **`ANTHROPIC_BASE_URL` is per-process global** — you cannot route some calls to Anthropic and others to DeepSeek within the same session
- **`CLAUDE_CODE_SUBAGENT_MODEL`** controls what model spawned subagents use — set to `deepseek-v4-flash` for cheap parallel agent work
- **Use `ANTHROPIC_AUTH_TOKEN`** not `ANTHROPIC_API_KEY` — Claude Code uses a different env var name
- **Shell function > alias** — the function correctly passes all flags through; multi-line aliases break in zsh

---

## 📁 Files

```
├── configs/
│   ├── zshrc.snippet       # zsh: env block + claude-ds function
│   ├── bashrc.snippet      # bash: env block (Ubuntu VPS default)
│   ├── settings.json       # .claude/settings.json per-project template
│   └── windows.ps1         # Windows PowerShell config
└── scripts/
    └── setup.sh            # Ubuntu automated installer
```

---

## 📚 Sources

- [DeepSeek Anthropic API Docs](https://api-docs.deepseek.com/guides/anthropic_api)
- [DeepSeek Coding Agents Guide](https://api-docs.deepseek.com/guides/coding_agents)
- [Claude Code Model Config Docs](https://code.claude.com/docs/en/model-config)

---

## 👤 Author

<div align="center">

<br>

**0x-elfateh** · Security Researcher & Bug Bounty Hunter

<br>

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0x--elfateh-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/0x-elfateh/)

<br>

*Found this useful? Drop a ⭐ — it helps others find it.*

<br>

</div>
