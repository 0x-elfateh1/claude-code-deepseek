<div align="center">

# ⚡ claude-code-deepseek

**Run Claude Code CLI on DeepSeek's Anthropic-compatible API**  
Built for security researchers & bug bounty hunters

```
┌──(user㉿vps)-[~]
└─$ claude-ds
 ▐▛███▜▌   Claude Code v2.1.166
▝▜█████▛▘  deepseek-v4-pro with high effort · API Usage Billing
  ▘▘ ▝▝    /home/user
❯ Try "how does <filepath> work?"
```

![DeepSeek](https://img.shields.io/badge/DeepSeek-v4--pro-blue?style=flat-square)
![Claude Code](https://img.shields.io/badge/Claude_Code-2.x-orange?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Cost](https://img.shields.io/badge/~%246_per_350M_tokens-💸-yellow?style=flat-square)
![Stars](https://img.shields.io/github/stars/0x-elfateh1/claude-code-deepseek?style=flat-square&color=gold)

</div>

---

## Table of Contents

- [Why DeepSeek?](#why-deepseek)
- [Model IDs](#model-ids)
- [Quick Setup](#quick-setup)
- [Setup Methods](#setup-methods)
  - [Method 1 — Global](#method-1--global-all-deepseek-always)
  - [Method 2 — Per-Project](#method-2--per-project-selective)
  - [Method 3 — Shell Function ⭐](#method-3--shell-function-per-session-)
  - [Method 4 — Automation / CI](#method-4--automation--ci)
- [Reverting to Anthropic](#reverting-to-anthropic-subscription)
- [Key Notes](#key-notes)
- [Files](#files)
- [Author](#author)

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

**Auto-mapping:** DeepSeek maps Claude names automatically — `claude-opus-*` → v4-pro, `claude-haiku/sonnet-*` → v4-flash.

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

Best if you want DeepSeek for everything.

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
