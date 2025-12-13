# DevBox

While working as a data engineer, I repeatedly ran into the same bottleneck: the gap between local development and validation.

A small code change often meant spinning up a cloud cluster just to test a single component. This slowed iteration, introduced unnecessary friction, and—most importantly—created a hard disconnect between my local environment and the system actually running the code.

That disconnect became even more apparent when working with AI tools. Agents couldn’t:
- access logs directly
- observe failures as they happened
- iterate autonomously on fixes

Validation lived “somewhere else,” and progress suffered because of it.

So I moved the cluster onto my local machine. Once everything ran locally, something clicked.

AI agents could execute commands, read logs, detect failures, and retry—without human glue code in between. Development stopped being a linear, line-by-line activity and became something else entirely.

**We weren’t just coding anymore. We were orchestrating.**

To make that orchestration explicit and safe, ChatGPT and I designed **DevBox**: a development box for your agent and your codebase.

**DevBox** is a lightweight, language‑agnostic **development execution contract** for humans *and* AI agents.

It defines:
- how a project is started
- how it is validated
- where logs and artifacts live
- what actions are allowed
- how agents may safely interact with the system

DevBox is **not** a framework, container, or runtime.  
It is a **thin control layer** around your existing project.

---

## Quick Start (Template)

```bash
cp .box/env/.env.local.example .box/env/.env.local
# set BOX_UP_CMD / BOX_DOWN_CMD / BOX_HEALTH_URL
.box/scripts/doctor.sh
.box/scripts/up.sh
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

DevBox makes the execution surface **explicit, deterministic, and safe**.

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
- tools (`box.run`, `box.health`, `box.read_logs`)
- resources (configs, state)
- prompts (optional)

MCP is **optional**. DevBox does not depend on MCP; MCP adapters depend on DevBox.

---

## Directory Layout

```text
.box/
├── box.yaml           # Source of truth (commands, env, signals)
├── policies.yaml      # Agent execution limits
├── scripts/           # Command implementations
├── state/             # Runtime state (pids, ports, metadata)
├── contracts/         # Invariants, APIs, schemas
└── mcp/               # MCP tool specification (optional)
```

---

## Example Flow

Human or agent interaction:

```text
Agent
  ↓
box.run("up")
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
