# Changelog

All notable changes to **DevBox** will be documented in this file.

This project follows a lightweight, human-readable changelog format.
Versions are tagged in Git.

---

## v0.2.0 — 2025-12-13

### Added
- support for `devbox mcp start` to run MCP server manually in foreground
- VS Code Copilot agent guardrails
- Cursor agent instructions
- MCP server ported into .box

### Changed
- MCP tool names standardized (`box-run`, etc.)
- devbox CLI auto-discovers repo root

### Fixed
- policy enforcement tightening

### Documentation
- updated README + QUICK_START to reflect new CLI
- added conformance docs

---

## v0.1.0 — Initial Public Template

### Added
- DevBox core contract under `.box/` (scripts, policies, state, contracts)
- `devbox` CLI for orchestration (`init`, `up`, `down`, `doctor`, `health`, `test`, `logs`, `reset`)
- Repo-root auto-discovery so `devbox` can be run from any subdirectory
- Optional MCP server under `.box/mcp/` for agent-based operation
- Bundled MCP server output for zero-install usage
- Explicit MCP opt-in via `devbox mcp enable`
- Safe-by-default agent policies (`safe-write` mode, allowlists, path restrictions)
- Language-agnostic runtime configuration via environment variables
- Deterministic log, report, and state directories
- VS Code / Cursor MCP wiring support

### Design Notes
- DevBox is a control-plane contract, not a framework or runtime
- MCP is optional; DevBox works fully without AI tooling
- Agents operate systems through explicit boundaries, not implicit access
- Local-first execution is a core principle

### Not Included (By Design)
- No Docker, containers, or cloud assumptions
- No CI/CD integration
- No editor lock-in
- No source-code mutation by agents

---

Future releases will focus on conformance levels, hardening, and ecosystem integrations.
