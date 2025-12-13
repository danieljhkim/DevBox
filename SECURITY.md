# Security Model

DevBox is designed to be **safe by default** for both human and agent operation.

This document explains the DevBox threat model, security assumptions, and the role of guardrails such as policies and deterministic execution.

---

## Threat Model

DevBox assumes the following environment:

- The repository owner controls the codebase.
- Local execution occurs on a developer or CI machine.
- AI agents may be granted *operational access* to the repository through a controlled interface (e.g. MCP).

The primary threats DevBox is designed to mitigate are:

- accidental destructive commands
- unintended filesystem access
- unconstrained shell execution by agents
- unclear or implicit execution surfaces

DevBox does **not** attempt to protect against:
- malicious repository owners
- compromised host machines
- vulnerabilities in the underlying application itself

---

## Design Principles

DevBox security is based on **constraint, not trust**.

Key principles:

- **Explicit execution** — only named commands may be run
- **Deterministic behavior** — commands do the same thing every time
- **Deny by default** — everything is forbidden unless explicitly allowed
- **Observable effects** — all actions produce machine-readable signals

---

## Command Safety

All executable actions are:

- explicitly named in `.box/box.yaml`
- implemented by a single script
- required to exit non-zero on failure

There is no support for:
- arbitrary shell execution
- dynamic command construction
- user-provided shell fragments

If a behavior is not defined in the DevBox contract, it is not allowed.

---

## Filesystem Guardrails

DevBox limits filesystem access through `policies.yaml`.

Policies:
- restrict readable paths
- restrict writable paths
- deny access outside the allowlist

Recommended defaults:
- read: `.box/`, `logs/`, `reports/`, `.box/contracts/`
- write: `.box/state/`, `reports/`

This prevents agents from:
- modifying source code
- accessing secrets
- traversing the filesystem

---

## Agent Operation

When agents are used:

- they interact only through DevBox commands
- policies MUST be enforced
- execution MUST be logged
- state MUST be inspectable

DevBox treats agents as **operators**, not authors.

They may observe and operate the system, but not redefine it.

---

## MCP Integration

If an MCP adapter is present:

- MCP tools MUST map 1:1 to DevBox commands
- MCP MUST NOT expose arbitrary shell access
- MCP MUST enforce `policies.yaml`

MCP is optional. DevBox remains secure without it.

---

## Reporting Security Issues

If you discover a security issue in DevBox itself:

- Please open a GitHub issue with the label `security`, or
- Contact the maintainer directly if disclosure should be coordinated

This project does not currently operate a bug bounty program.

---

## Final Note

DevBox intentionally favors **explicitness over flexibility**.

If something feels restrictive, it is likely by design.
Security boundaries are easier to loosen than to retroactively add.
