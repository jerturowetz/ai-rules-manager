---
id: ai_negative_testing
scope: domain
category: testing
description: "Methodology for negative testing of AI systems to ensure safe, predictable behavior"
domains: [ai, testing, quality-assurance, safety]
tools_excluded: []
---

# AI Negative Testing

Negative testing with AI tools explores *what happens when things go wrong* rather than only checking normal operations. Ensure AI systems behave safely, predictably, and transparently when exposed to unexpected, invalid, or adversarial inputs.

## Core principle

Instead of confirming that AI works as intended (positive testing), negative testing asks:
- What happens if the input is malformed, incomplete, or nonsensical?
- How does the AI respond to edge cases or out-of-scope requests?
- Does the AI fail gracefully with clear error messages, or generate harmful, biased, or misleading output?

## Testing categories

### Input validation
- Feed empty prompts, extremely long strings, or corrupted data
- Check if it crashes, loops, or produces misleading results

### Adversarial or malicious prompts
- Test prompt injection attempts (e.g., "ignore previous instructions")
- Verify resilience against jailbreaks that bypass safety rules

### Bias and ethics checks
- Supply biased or discriminatory inputs
- Verify whether the AI reproduces or amplifies harmful bias

### Boundary conditions
- Enter values at upper or lower limits (extreme numbers, edge case formats)
- Use rare languages or dialects to see if system degrades safely

### System integration
- Test how AI responds when upstream systems provide bad data
- Test when downstream APIs fail
- Ensure errors are surfaced clearly instead of silently propagating

## Why it matters

- Reduces risk of harmful or misleading outputs
- Improves robustness and trustworthiness
- Helps teams uncover vulnerabilities that normal ("happy path") testing misses
- Essential for compliance and safety reviews of AI products