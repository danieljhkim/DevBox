# Settings

This directory contains **sample configuration and instruction files** intended to be reused across repositories.

The files here are **not meant to be used verbatim**. Instead, users should **copy, adapt, and selectively apply** them based on the needs and risk profile of each project.

---

## Purpose

The goal of this directory is to:

- Provide high-quality, opinionated starting points
- Reduce setup time for new repositories
- Encourage consistent, production-grade defaults
- Make expectations explicit for both humans and tools (e.g., AI agents)

Each file represents a **template or reference implementation**, not a mandate.

---

## How to Use

Typical workflow:

1. Browse the files in this directory
2. Copy the ones that are relevant to your repository
3. Modify language, scope, and strictness as needed
4. Commit the customized version into the target repo

Do **not** symlink or depend on these files directly unless you explicitly want shared coupling.

---

## Contents

Examples of what you may find here:

- Cursor agent instruction templates (e.g., strict infra vs. general-purpose)
- Editor or tooling configuration samples
- Opinionated guidelines for automation, scripts, or workflows
- Reference documentation meant to be tailored per repo

The exact contents may evolve over time.

---

## Design Philosophy

These samples favor:

- Explicit behavior over implicit conventions
- Minimal, reviewable changes over broad refactors
- Safety and reversibility for high-blast-radius code
- Clear boundaries between infrastructure and product code

If something feels too strict or too loose, it probably should be adjusted for your use case.

---

## What This Is Not

This directory is **not**:

- A centralized policy that all repos must follow
- A drop-in dependency
- A replacement for repo-specific documentation

Treat these files as **building blocks**, not rules.

---

## Recommendations

- Keep copies short and repo-specific
- Prefer tightening rules over time rather than starting overly permissive
- Revisit instructions as the project matures

---

## Questions or Changes

If you adapt one of these samples and discover a clear improvement:

- Generalize it
- Remove repo-specific assumptions
- Consider adding it back here as a new sample

The intent is gradual refinement, not rigid standardization.
