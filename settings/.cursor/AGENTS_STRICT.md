# Cursor Agents Configuration (Infra-Only, Strict)

This document defines how Cursor Agents should behave when working in this repository.
The goal is safe, production-grade changes to infrastructure, tooling, and developer workflow config.

--------------------------------------------------------------------------------

## Scope

Treat this repository as infrastructure:
- Developer tooling configuration and automation
- Editor/runtime settings that can impact multiple projects
- Scripts that may run on developer machines or CI

Default assumption: changes here are high blast-radius.

--------------------------------------------------------------------------------

## Operating Principles

1. Safety first
   - Prefer correctness and reversibility over speed
   - Avoid behavior changes unless explicitly requested

2. Minimal, reviewable diffs
   - Make the smallest change that satisfies the request
   - Do not refactor, reformat, or rename unrelated code

3. Deterministic behavior
   - Avoid hidden defaults and implicit environment assumptions
   - Document any required env vars, OS assumptions, and prerequisites

4. Compatibility bias
   - Prefer backward-compatible changes
   - Avoid breaking workflows, paths, or command-line interfaces

--------------------------------------------------------------------------------

## Hard Rules

Agents must NOT:
- Make network calls or require external services
- Generate or request secrets/credentials/tokens
- Change or introduce telemetry without explicit instruction
- Add new dependencies without explicit instruction
- Change public interfaces (CLI args, file formats, config schemas) without explicit instruction
- Modify multiple areas of the repo “while here” (no opportunistic cleanup)

--------------------------------------------------------------------------------

## Change Policy

When proposing or implementing a change, always consider:
- Blast radius: who/what could break (local dev, CI, editor behavior)
- Rollback: can the change be reverted cleanly
- Migration: if behavior must change, provide a safe transition path

If a breaking change is explicitly requested:
- Make it opt-in when possible
- Provide a migration note in the docs and/or inline comments

--------------------------------------------------------------------------------

## Error Handling and Logging

For scripts/tools:
- Fail fast with clear error messages and non-zero exit codes
- Validate inputs early (paths, env vars, required tools)
- Avoid noisy logs; prefer concise, actionable output
- Never print secrets or sensitive values

--------------------------------------------------------------------------------

## Concurrency and Performance

- Do not introduce concurrency unless explicitly requested
- If concurrency is required, keep it bounded and deterministic
- Avoid background daemons unless explicitly requested
- Prefer predictable resource usage over micro-optimizations

--------------------------------------------------------------------------------

## Testing and Validation

Do not assume tests exist.

If tests are present:
- Update or add tests for any behavior change

If tests are missing:
- Provide a short validation checklist (manual steps) relevant to the change
- Do not invent new test frameworks

For any change that affects developer workflows, include:
- How to run/verify locally
- Expected output or observable behavior

--------------------------------------------------------------------------------

## Documentation Expectations

When behavior/config changes:
- Update relevant README/docs or inline comments
- Document defaults, assumptions, and any migration steps
- Keep documentation short and operational (no marketing language)

--------------------------------------------------------------------------------

## Communication Style

Responses should be:
- Concise
- Technical
- Actionable

Preferred structure:
- What changed
- Why (risk/tradeoff)
- How to validate

Avoid:
- Emojis
- Overly verbose explanations
- Apologies or hedging language

--------------------------------------------------------------------------------

## Definition of Done

A task is complete when:
- The requested change is implemented
- The diff is minimal and focused
- Compatibility and rollback considerations are addressed
- Validation steps (or tests) are included when relevant

--------------------------------------------------------------------------------

## Escalation and Uncertainty

If instructions are ambiguous:
- State assumptions explicitly
- Ask one clarifying question only if absolutely necessary
- Otherwise, proceed with the safest reasonable interpretation