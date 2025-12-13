# DevBox Specification

**Version:** 0.1.0  
**Status:** Draft (stable for v0.1 adopters)

This document defines the **normative specification** for DevBox.

Any repository claiming to be *DevBox-enabled* MUST conform to this specification.

---

## 1. Purpose

DevBox defines a **deterministic execution contract** for local development.

It standardizes how systems are:
- started
- stopped
- validated
- observed

DevBox is designed to be:
- language-agnostic
- tool-agnostic
- safe for human and agent operation

---

## 2. Non-Goals

DevBox explicitly does NOT:
- define a build system
- replace CI/CD
- manage production deployments
- execute arbitrary shell commands
- enforce a project structure outside `.box/`

---

## 3. Terminology

- **Box**: The DevBox contract applied to a repository
- **Command**: A named, allowlisted action (e.g. `up`, `test`)
- **Script**: The concrete implementation of a command
- **Signal**: Machine-readable output (logs, health, reports, state)
- **Agent**: Any non-human operator (AI, automation, CI)

Normative keywords **MUST**, **SHOULD**, and **MAY** are used as defined in RFC 2119.

---

## 4. Required Files and Layout

A DevBox-enabled repository MUST contain:

```text
.box/
├── box.yaml           # command contract (required)
├── policies.yaml      # execution limits (required)
└── scripts/           # command implementations (required)
```

The following directories MUST exist at runtime:

```text
logs/
reports/
.box/state/
```

---

## 5. box.yaml

`box.yaml` is the **single source of truth** for the DevBox contract.

It MUST define:
- command names
- command intent
- runtime environment defaults
- signals (health, logs, reports, state)

`box.yaml` MUST be static and version-controlled.

### 5.1 Environment Variables

Environment variables:
- MUST be declared under `runtime.env`
- MUST only tune execution
- MUST NOT redefine the contract

---

## 6. Commands

Commands are **named entry points**.

Each command:
- MUST have a unique name
- MUST map to exactly one script
- MUST exit non-zero on failure
- MUST be deterministic

### 6.1 Required Commands (Core Conformance)

The following commands are REQUIRED for Core conformance:

| Command | Purpose |
|-------|--------|
| `up` | Start the local system |
| `down` | Stop the local system |
| `health` | Check readiness |
| `doctor` | Validate DevBox setup |

---

### 6.2 Recommended Commands

The following commands are RECOMMENDED:

| Command | Purpose |
|-------|--------|
| `test` | Validate correctness |
| `smoke` | Fast health validation |
| `logs` | Inspect runtime logs |
| `reset` | Clear DevBox state |

---

### 6.3 Optional Commands

The following commands are OPTIONAL:

| Command | Purpose |
|-------|--------|
| `lint` | Static analysis |
| `fmt` | Formatting |
| `bench` | Performance tests |
| `report` | Summarize artifacts |
| `bootstrap` | One-time setup |

---

## 7. Conformance Levels

A repository MAY claim one of the following conformance levels:

### 7.1 Core
- All required files present
- All required commands implemented
- Deterministic execution
- Stable signals

### 7.2 Extended
- Core conformance
- All recommended commands implemented
- Test artifacts written to `reports/`

### 7.3 Agent-Ready
- Extended conformance
- `policies.yaml` restricts execution
- Stable log and state locations
- Optional MCP adapter present

Conformance claims MUST be documented (e.g. in README).

---

## 8. Signals

Signals are **machine-consumable outputs**.

### 8.1 Logs
- MUST be written to `logs/`
- SHOULD be line-oriented text
- MAY be rotated or segmented

### 8.2 Reports
- MUST be written to `reports/`
- SHOULD be deterministic
- MAY be empty

### 8.3 State
- MUST be written to `.box/state/`
- MUST NOT contain secrets
- SHOULD include runtime metadata (ports, pids, timestamps)

### 8.4 Health
- MUST be checkable via the `health` command
- MUST exit non-zero on failure
- SHOULD be fast (<2s)

---

## 9. Policies

`policies.yaml` defines **execution guardrails**.

Policies:
- MUST restrict command execution
- MUST define readable paths
- MUST define writable paths
- MUST deny by default

---

## 10. Agents and MCP

DevBox does not require MCP.

If MCP is used:
- tools MUST map to DevBox commands
- arbitrary shell execution MUST NOT be exposed
- policies MUST be enforced

---

## 11. Versioning

The specification version is declared in this document.

Breaking changes:
- MUST increment the major version
- MUST be documented in CHANGELOG

Non-breaking changes:
- MAY increment the minor version

---

## 12. Compliance Checklist

A DevBox-enabled repository MUST:

- [ ] Include required files
- [ ] Implement required commands
- [ ] Write logs to `logs/`
- [ ] Write state to `.box/state/`
- [ ] Exit non-zero on failure
- [ ] Document conformance level

---

## 13. Rationale

DevBox exists to make systems **operable**, not magical.

If a behavior is not explicitly defined here, it is not part of the contract.
