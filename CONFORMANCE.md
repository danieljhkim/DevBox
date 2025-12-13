# DevBox Conformance

This document explains how a repository can claim conformance to the **DevBox Specification**.

The normative requirements live in `SPEC.md`. This file is **practical guidance**: what to implement, what to say in your README, and what reviewers should check.

---

## Conformance Levels

A repository MAY claim one of the following conformance levels:

- **Core** (minimum viable DevBox)
- **Extended** (recommended for most active projects)
- **Agent-Ready** (safe for autonomous agent operation)

Your README SHOULD declare the level explicitly.

Example:

```md
**DevBox Conformance:** Extended
```

---

## Core Conformance

**Core** is the minimal bar for calling a repo *DevBox-enabled*.

### Required files
A Core repo MUST include:

- `.box/box.yaml`
- `.box/policies.yaml`
- `.box/scripts/`

### Required runtime directories
At runtime, these MUST exist:

- `logs/`
- `reports/`
- `.box/state/`

### Required commands
Core requires these commands to exist in `.box/box.yaml` and be runnable:

- `up` — start the local system
- `down` — stop the local system
- `health` — check readiness (exit non-zero on failure)
- `doctor` — validate DevBox setup

### Behavioral requirements
- Commands MUST be deterministic given the same inputs.
- Commands MUST exit non-zero on failure.
- Logs MUST be written under `logs/`.
- State MUST be written under `.box/state/`.
- State MUST NOT include secrets.

### Recommended README snippet

```md
## DevBox

**DevBox Conformance:** Core

Quick commands:
- `.box/scripts/doctor.sh`
- `.box/scripts/up.sh`
- `.box/scripts/smoke.sh --health`
- `.box/scripts/down.sh`
```

---

## Extended Conformance

**Extended** is Core plus a complete developer feedback loop.

### Additional required commands
Extended requires all Core commands plus these to be implemented:

- `test` — validate correctness (unit/integration checks)
- `smoke` — fast validation (may be best-effort)
- `logs` — inspect runtime logs
- `reset` — clear DevBox state (non-destructive)

### Additional behavioral requirements
- `test` SHOULD write artifacts (reports, summaries) to `reports/`.
- `reset` SHOULD preserve `logs/` (delete only `.box/state/` and `reports/`).

### Recommended README snippet

```md
**DevBox Conformance:** Extended

Typical flow:
1. `.box/scripts/doctor.sh`
2. `.box/scripts/up.sh`
3. `.box/scripts/smoke.sh --health`
4. `.box/scripts/test.sh`
5. `.box/scripts/down.sh`
```

---

## Agent-Ready Conformance

**Agent-Ready** is Extended plus explicit guardrails that make autonomous operation safe.

### Requirements
- Must meet **Extended** conformance.
- `.box/policies.yaml` MUST be **deny-by-default** and allowlist only DevBox commands.
- Policies MUST restrict:
  - readable paths (e.g. `.box/`, `logs/`, `reports/`)
  - writable paths (e.g. `.box/state/`, `reports/`)
- State and logs MUST have stable locations for agents to discover signals.

### Optional (recommended)
- Provide an MCP adapter contract at `.box/mcp/server.json`.
- Expose only:
  - `box.run`
  - `box.health`
  - `box.read_logs`
  - `box.read_contract`

### Recommended README snippet

```md
**DevBox Conformance:** Agent-Ready

Agent access:
- MCP contract: `.box/mcp/server.json`
- Policies: `.box/policies.yaml`
```

---

## Reviewer Checklist

Use this checklist in PRs when someone claims DevBox conformance.

### Core
- [ ] `.box/box.yaml` exists and lists `up/down/health/doctor`
- [ ] `.box/scripts/` contains corresponding scripts
- [ ] Commands fail fast and return non-zero on errors
- [ ] `logs/`, `reports/`, `.box/state/` are produced at runtime

### Extended
- [ ] Implements `test/smoke/logs/reset`
- [ ] `test` writes outputs to `reports/` (even a simple summary is OK)
- [ ] `reset` clears state/reports without deleting logs

### Agent-Ready
- [ ] `policies.yaml` is deny-by-default
- [ ] Allowlist is minimal and explicit
- [ ] Read/write paths are restricted
- [ ] No arbitrary shell exposed via agent adapters

---

## Notes

- Conformance levels are about **operability**, not sophistication.
- A small repo can be Agent-Ready if its boundaries are explicit and safe.
- If a behavior is not described in `SPEC.md`, it is not part of DevBox.
