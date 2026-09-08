# Codex configuration

Personal Codex settings, global instructions, and explorer/worker/reviewer agents.
Configuration loading checked with Codex CLI **0.153.4**.

## Install

Requires Bash and GNU coreutils (`cp`), as provided on Linux. From this checkout:

```bash
./install.sh
```

The script copies `config.toml`, `AGENTS.md`, and the three `agents/*.toml` files
into `${CODEX_HOME:-$HOME/.codex}`, keeping the same relative paths. You can run
it from any working directory or choose another destination:

```bash
CODEX_HOME=/path/to/codex ./install.sh
```

Existing destination files are backed up beside their replacements as
`config.toml.~1~`, `config.toml.~2~`, etc. Existing file symlinks are backed up
and replaced without changing their targets. Other files and agents are kept.
To restore a file, move its chosen backup over the installed file.

Installation replaces these files; it does not merge settings. Review the
machine-specific trusted project paths in `config.toml` before installing.
Re-run the script after changing this checkout, then start a new Codex session.

## Plugins

Install plugins separately after copying the configuration:

```bash
codex plugin add github@openai-curated
codex plugin marketplace add https://github.com/DietrichGebert/ponytail.git
codex plugin add ponytail@ponytail
codex plugin list
```

Complete any authentication or hook-trust prompts shown by Codex. Plugin
downloads, credentials, and local hook-trust records are not installed by this
script. Use the same `CODEX_HOME` for these commands if you chose a custom path.

## Verify

```bash
python3 test_install.py
codex features list
```

The installer check uses temporary directories and leaves your live Codex
configuration alone. `codex features list` checks configuration loading.
In a new Codex session, ask it to use the `explorer`, `worker`, and `reviewer`
roles to verify agent discovery. See the official OpenAI documentation for
[configuration](https://learn.chatgpt.com/docs/config-file/config-reference) and
[custom agents](https://learn.chatgpt.com/docs/agent-configuration/subagents).
