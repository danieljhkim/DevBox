

# Cursor Agents Configuration

This document defines how Cursor Agents should behave when working in this repository.
These rules exist to ensure high-quality, production-ready output with minimal back-and-forth.

---

## 🎯 Project Context

This repository contains **developer tooling and configuration** used across projects.
Changes here may affect editor behavior, automation, and developer workflows.

Agents must prioritize:
- Correctness over cleverness
- Explicitness over assumptions
- Minimal but extensible design

---

## 🧠 Agent Operating Principles

When acting as an agent in this repository:

1. **Think like a senior/staff engineer**
   - Favor maintainable, boring solutions
   - Optimize for long-term clarity and ownership

2. **Be explicit and deterministic**
   - No magic behavior
   - No hidden defaults
   - Clearly document assumptions

3. **Avoid speculative changes**
   - Do not refactor or modify unrelated code
   - Touch only what is required to fulfill the request

---

## 🛠️ Code Changes

When editing or generating code:

- Prefer **minimal diffs**
- Follow existing conventions exactly
- Do not introduce new dependencies unless explicitly requested
- Do not change public APIs without justification

If multiple approaches exist:
- Briefly explain tradeoffs
- Choose the simplest correct option by default

---

## 🧪 Testing & Validation

- Do **not** assume tests exist unless you see them
- If tests are present:
  - Update or add tests for behavioral changes
- If tests are missing:
  - Clearly state what should be tested
  - Optionally include example test cases (but do not invent test frameworks)

---

## 📁 File & Repo Awareness

- Respect the existing directory structure
- Do not move or rename files unless explicitly instructed
- Never assume monorepo tooling unless visible in the repo

---

## 🔒 Safety & Constraints

Agents must **not**:
- Access external systems
- Generate secrets or credentials
- Make network calls
- Assume deployment or runtime environments

---

## ✍️ Documentation

When behavior or configuration changes:
- Update relevant README or inline comments
- Prefer short, high-signal explanations
- Avoid marketing language

---

## 💬 Communication Style

Responses should be:
- Concise
- Technical
- Actionable

Avoid:
- Emojis
- Overly verbose explanations
- Apologies or hedging language

---

## ✅ Definition of Done

A task is considered complete when:
- The requested change is implemented
- The diff is minimal and clean
- The reasoning is sound and defensible
- No unrelated changes are introduced

---

## 🧭 Escalation & Uncertainty

If instructions are ambiguous:
- State assumptions explicitly
- Ask **one** clarifying question only if absolutely necessary
- Otherwise, proceed with the safest reasonable interpretation