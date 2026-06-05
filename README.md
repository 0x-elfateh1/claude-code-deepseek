# Claude Code × DeepSeek — Setup Guide

> Run Claude Code CLI with DeepSeek's Anthropic-compatible API.
> ~350M tokens for ~$6 · Perfect for high-volume security automation & bug bounty workflows.

**By [0x-elfateh](https://www.linkedin.com/in/0x-elfateh/) · Security Researcher & Bug Bounty Hunter**

---

## Why DeepSeek?

| | Anthropic Subscription | DeepSeek API |
|---|---|---|
| Interactive coding | ✅ Best | ✅ Good |
| Headless / VPS automation | ❌ Needs OAuth | ✅ API key works |
| Rate limits | Subscription caps | Pay-per-token, no hard caps |
| Cost at scale | Fixed monthly | ~$6 per 350M tokens |

**Strategy:** Use your Claude subscription for interactive daily work. Use DeepSeek API for VPS automation, CI pipelines, and heavy subagent workloads.

---

## Model IDs

| Model | ID | Use |
|---|---|---|
| Flagship | `deepseek-v4-pro` | Heavy reasoning, main agent |
| Fast/Cheap | `deepseek-v4-flash` | Subagents, background tasks |

> ⚠️ `deepseek-chat` and `deepseek-reasoner` are **deprecated July 24 2026**. Don't use them.

**Auto-mapping:** DeepSeek maps Claude names — `claude-opus-*` → v4-pro, `claude-haiku/sonnet-*` → v4-flash.

---

## Quick Setup

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

See ready-to-use snippets in [`configs/`](./configs/).

---

## Setup Methods

### Method 1 — Global (All DeepSeek, Always)

```bash
cat >> ~/.zshrc << 'EOF'
export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
export ANTHROPIC_AUTH_TOKEN=<your_deepseek_key>
export ANTHROPIC_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash
export CLAUDE_CODE_SUBAGENT_MODEL=deepseek-v4-flash
export CLAUDE_CODE_EFFORT_LEVEL=max
EOF
source ~/.zshrc
```

---

### Method 2 — Per-Project (Selective)

Create `.claude/settings.json` in your project folder. See [`configs/settings.json`](./configs/settings.json).

---

### Method 3 — Shell Function (Per-Session) ⭐ Recommended

> ⚠️ Use a **function**, not an alias. Multi-line aliases are fragile in zsh.

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

- `claude` → Anthropic subscription (unchanged)
- `claude-ds` → DeepSeek session
- `claude-ds -p "task"` → passes all flags through via `"$@"`

---

### Method 4 — Automation / CI

```bash
ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic" \
ANTHROPIC_AUTH_TOKEN="<your_deepseek_key>" \
ANTHROPIC_MODEL="deepseek-v4-pro" \
CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash" \
claude --dangerously-skip-permissions -p "your task here"
```

---

## VPS Install (Ubuntu)

```bash
# One-command installer:
DEEPSEEK_KEY=sk-... bash <(curl -s https://raw.githubusercontent.com/0x-elfateh1/claude-code-deepseek/main/scripts/setup.sh)
```

Or manually — see [`scripts/setup.sh`](./scripts/setup.sh).

---

## Reverting to Anthropic Subscription

```bash
unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_MODEL \
      ANTHROPIC_DEFAULT_OPUS_MODEL ANTHROPIC_DEFAULT_SONNET_MODEL \
      ANTHROPIC_DEFAULT_HAIKU_MODEL CLAUDE_CODE_SUBAGENT_MODEL \
      CLAUDE_CODE_EFFORT_LEVEL
```

Permanent: remove the export lines from `~/.zshrc` / `~/.bashrc`.

---

## Key Notes

- `ANTHROPIC_BASE_URL` is per-process global — can't split Anthropic/DeepSeek in the same session
- `CLAUDE_CODE_SUBAGENT_MODEL` controls spawned subagent model
- Use `ANTHROPIC_AUTH_TOKEN` not `ANTHROPIC_API_KEY` for Claude Code
- Get your key at [platform.deepseek.com](https://platform.deepseek.com)

---

## Files

```
configs/
├── zshrc.snippet       # zsh env block + claude-ds function
├── bashrc.snippet      # bash env block (Ubuntu VPS)
├── settings.json       # .claude/settings.json per-project template
└── windows.ps1         # Windows PowerShell config
scripts/
└── setup.sh            # Ubuntu VPS one-command installer
```

---

## Sources

- [DeepSeek Anthropic API Docs](https://api-docs.deepseek.com/guides/anthropic_api)
- [DeepSeek Coding Agents Guide](https://api-docs.deepseek.com/guides/coding_agents)
- [Claude Code Model Config Docs](https://code.claude.com/docs/en/model-config)

---

## Author

**0x-elfateh** — Security Researcher & Bug Bounty Hunter
🔗 [linkedin.com/in/0x-elfateh](https://www.linkedin.com/in/0x-elfateh/)

If this helped you, leave a ⭐
