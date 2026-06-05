#!/bin/bash
# Claude Code × DeepSeek — Ubuntu VPS one-command installer
# Usage: DEEPSEEK_KEY=sk-... bash setup.sh
set -e

if [ -z "$DEEPSEEK_KEY" ]; then
  echo "Usage: DEEPSEEK_KEY=sk-... bash setup.sh"
  exit 1
fi

echo "[1/4] Installing Node.js 22..."
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

echo "[2/4] Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

echo "[3/4] Writing DeepSeek config to ~/.bashrc..."
cat >> ~/.bashrc << ENVEOF
# Claude Code x DeepSeek
export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
export ANTHROPIC_AUTH_TOKEN=${DEEPSEEK_KEY}
export ANTHROPIC_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro
export ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash
export CLAUDE_CODE_SUBAGENT_MODEL=deepseek-v4-flash
export CLAUDE_CODE_EFFORT_LEVEL=max
ENVEOF

source ~/.bashrc
echo "[4/4] Done. Run: claude --dangerously-skip-permissions"
