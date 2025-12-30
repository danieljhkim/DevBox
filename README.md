# DevBox

Modern repos are increasingly operated by AI agents.

In practice, that has created a new kind of operational debt: **instruction fatigue**.

Every new agent workflow (Cursor, Claude Code, Copilot, custom CLIs, MCP tools, etc.) tends to introduce its own rule files and conventions—`.cursorrules`, `.claudecode`, prompt snippets, allowlists, scripts, and one-off docs. Over time these accumulate, drift out of date, and clutter the repo with fragmented “sources of truth.”

The result is predictable:
- onboarding is slower
- local workflows are inconsistent
- agents are powerful but unsafe (or safe but ineffective)
- execution knowledge lives in too many places

**DevBox** is a lightweight, language‑agnostic **execution contract** that makes your repo’s development interface explicit, deterministic, and policy‑gated for both humans and AI agents.

DevBox lives in `.box/` and centralizes:
- how to start/stop the system locally
- how to validate changes
- where logs and artifacts live
- what actions are allowed under each policy

It defines:
- how a project is started
- how it is validated
- where logs and artifacts live
- what actions are allowed
- how agents may safely interact with the system

DevBox is **not** a framework, container, or runtime.  
It is a **thin control layer** around your existing project.

---

## Installation

### Homebrew (Recommended)

```bash
# 0) Install DevBox
brew tap danieljhkim/tap
brew install danieljhkim/tap/devbox


# 1) Install DevBox into the target repo
cd /path/to/your-repo
devbox init .

# 2) Configure local runtime commands
cp .box/env/.env.local.example .box/env/.env.local
# edit .box/env/.env.local and set BOX_UP_CMD / BOX_DOWN_CMD / BOX_HEALTH_URL

# 3) Verify and start (can be run from anywhere inside the repo)
devbox doctor
devbox up

# 4) (Optional) Inspect or switch agent execution policy
devbox policy show
devbox policy list
devbox policy set safe-write
```

See `QUICK_START.md` for the full workflow.

---

## Why DevBox Exists

Modern development environments are no longer operated only by humans.

AI agents can now:
- run code
- read logs
- retry failures
- iterate autonomously

But most repositories expose **implicit**, undocumented, and unsafe execution surfaces:
- ad‑hoc shell scripts
- undocumented Make targets
- fragile local instructions
- unrestricted command execution

To enforce tighter rules, we are forced to maintain fragmented, tool-specific rules (.cursorrules, .claudecode, etc.) for every new agentic workflow. And with every new agentic IDE or CLI tools we adopt, more of these fragmented instructions clutter our codebase and our mind. 

DevBox aims to solve this by providing a universal source of truth for all agentic workflows.

At the least, I hope it can provide some inspirations.

---

## What DevBox Is (and Is Not)

### ✅ Is
- A **contract** for local development
- A **deterministic execution surface**
- **Agent‑safe** by design
- Language‑ and framework‑agnostic
- Compatible with MCP (Model Context Protocol)

### ❌ Is Not
- A replacement for Docker, Bazel, or Make
- A CI system
- A production runtime
- A magic abstraction

DevBox *wraps* what you already have — it does not replace it.

---

## Core Concepts

### 1. Commands

All project actions are normalized into named commands.

Examples:
- `up` – start the local system
- `down` – stop it
- `test` – validate correctness
- `health` – check readiness
- `logs` – inspect execution

Each command maps to a **single, deterministic implementation**.

---

### 2. Policies

Policies define **what agents are allowed to do**.

They specify:
- allowed commands
- readable paths
- writable paths
- execution limits

This prevents accidental or malicious actions while enabling autonomy.

Policies are managed via named profiles (for example: `readonly`, `safe-write`, `admin`)
stored under `.box/policies/`. One profile is active at a time.

You can inspect or switch the active policy using:

```bash
devbox policy show
devbox policy list
devbox policy set readonly|safe-write|admin
```

---

### 3. Signals

Signals are machine‑readable outputs produced by the system:
- health checks
- logs
- reports
- state snapshots

Agents consume **signals**, not human intuition.

---

### 4. MCP Integration (Optional)

DevBox can be exposed to AI agents via MCP:
- tools (`box-run`, `box-health`, `box-read-logs`)
- resources (configs, state)
- prompts (optional)

MCP is **optional** and explicitly opt-in.  
DevBox does not depend on MCP; MCP adapters depend on DevBox.

To enable MCP wiring for VS Code:

```bash
devbox mcp enable
```

This creates `.vscode/mcp.json` pointing to the DevBox MCP server under `.box/`.  And installs and builds the MCP server.

```bash
# (optional) start the MCP server manually (foreground, stdio)
# Useful for debugging or non-editor hosts
devbox mcp start
```

#### Editor Support

- **VS Code / Cursor**: native MCP support via `mcp.json`
- **IntelliJ / JetBrains**: no native MCP support yet  
  Use the DevBox CLI (`devbox up`, `devbox test`, etc.) or IDE External Tools integration

DevBox itself is editor‑agnostic; MCP is an optional adapter where supported.

---

## Directory Layout

```text
.box/
├── box.yaml           # Source of truth (commands, env, signals)
├── policies.yaml      # Agent execution limits
├── scripts/           # Command implementations
├── state/             # Runtime state (pids, ports, metadata)
├── contracts/         # Invariants, APIs, schemas
└── mcp/               # MCP server + tool specification (optional)
```

---

## Example Flow

Human or agent interaction:

```text
Agent
  ↓
box-run("up")
  ↓
.box/scripts/up.sh
  ↓
Local system starts
  ↓
Signals emitted (logs, health)
```

The same flow works for:
- humans
- CI
- AI agents
- automation

---

## DevBox CLI

When `devbox` is on your `PATH`, all core commands are available from anywhere inside the repository:

```bash
devbox doctor
devbox up
devbox health
devbox test
devbox logs
devbox down
devbox policy show
devbox policy set safe-write
```

The CLI discovers the repo root automatically by locating `.box/`.

---

## Design Principles

- **Single source of truth**
- **Fail fast**
- **Deterministic behavior**
- **Explicit contracts**
- **Minimal surface area**

If it is not in DevBox, it is not supported.

---

## Status

DevBox is an **emerging pattern**, not a formal standard.
It represents a convergence of:
- hermetic dev environments
- policy‑gated execution
- agent‑operated systems

Expect evolution — not churn.

---

## Philosophy

> Humans design and orchestrate.  
> Systems execute deterministically.  
> Agents iterate within guardrails.  
>  
> DevBox defines the boundary between intent and execution.

---

**DevBox Conformance:** Core  
(Extended and Agent-Ready supported via configuration)

## License

MIT
