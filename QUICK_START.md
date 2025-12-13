# DevBox Quick Start

This guide shows how to adopt DevBox in an existing repository in **under 5 minutes**.

DevBox does not replace your tooling.  
It wraps what you already have and makes it **explicit, deterministic, and operable**.

---

## Prerequisites

- A repository with a way to:
  - start the system locally
  - stop it
  - validate changes (tests, checks, etc.)
- POSIX shell (`sh`)
- No Docker, CI, or framework assumptions required

---

## 1. Install DevBox

From the DevBox template repo:

```bash
./devbox init /path/to/your-repo --minimal --gitignore
```

Or from inside the target repo:

```bash
/path/to/devbox-template/devbox init . --minimal --gitignore
```

To preview changes without modifying anything:

```bash
./devbox init . --minimal --gitignore --dry-run
```

This creates:

```text
.box/
logs/
reports/
```

---

## 2. Configure Runtime Commands (Option B)

DevBox is **language-agnostic**.  
You tell it how to run your system.

Create a local override file:

```bash
cp .box/env/.env.local.example .box/env/.env.local
```

Edit `.box/env/.env.local` and set:

```env
BOX_UP_CMD="./scripts/start_local.sh"
BOX_DOWN_CMD="./scripts/stop_local.sh"
BOX_HEALTH_URL="http://localhost:8080/health"
```

Notes:
- These values are **machine-local**
- `.box/env/.env.local` should not be committed
- DevBox scripts read these at runtime

---

## 3. Verify the Environment

Run the diagnostic check:

```bash
.box/scripts/doctor.sh
```

This verifies:
- required files exist
- scripts are executable
- env configuration is present
- directories are writable

Fix any reported issues before continuing.

---

## 4. Start the System

```bash
.box/scripts/up.sh
```

What this does:
- runs your start command deterministically
- streams output to `logs/box-up.log`
- records runtime metadata in `.box/state/`

---

## 5. Check Health

```bash
.box/scripts/smoke.sh --health
```

DevBox will:
- poll `BOX_HEALTH_URL`
- retry until healthy or timeout
- exit non-zero on failure

This command is safe to run repeatedly.

---

## 6. Validate Changes

```bash
.box/scripts/test.sh
```

This script should:
- run fast, deterministic validation
- write artifacts to `reports/`
- exit non-zero on failure

DevBox does not enforce *how* tests run — only *where outputs go*.

---

## 7. Inspect Logs and State

Logs:
```bash
ls logs/
```

Runtime state:
```bash
ls .box/state/
```

These paths are **stable** and safe for:
- humans
- CI
- AI agents

---

## 8. Stop the System

```bash
.box/scripts/down.sh
```

This should:
- stop all local processes
- clean up transient state
- exit cleanly even if already stopped

---

## Optional: MCP Integration

DevBox can be exposed to AI agents via MCP (Model Context Protocol).

This is **optional**.

If enabled, agents may:
- run allowlisted commands
- read logs and contracts
- check system health

DevBox itself does not depend on MCP.

See `.box/mcp/README.md` for details.

---

## Common Patterns

### No long-running runtime?
Set no-op commands:

```env
BOX_UP_CMD="echo 'no runtime to start'"
BOX_DOWN_CMD="echo 'no runtime to stop'"
```

### Slow startup?
Increase retries:

```env
BOX_HEALTH_RETRIES=40
BOX_HEALTH_SLEEP_SECS=2
```

---

## Mental Model

- `box.yaml` defines **what exists**
- scripts define **how it runs**
- env vars tune **where and how**
- signals define **what machines observe**

If it’s not in DevBox, it’s not supported.

---

## Next Steps

- Review `SPEC.md` for the formal contract
- Tighten `.box/policies.yaml` before enabling agents
- Customize `test.sh` and `smoke.sh` for your repo

You now have a deterministic, agent-operable development environment.

Welcome to orchestration.
