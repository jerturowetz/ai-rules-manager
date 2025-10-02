---
id: simple_solutions_principle
scope: global
category: architecture
description: "Prefer simple, direct solutions over complex workarounds"
tools_excluded: []
---

# Simple Solutions Principle

Prefer simple, direct solutions over complex workarounds. When you find yourself adding layers of abstraction, parameters, or conditional logic to solve a problem, step back and ask: "Is there a simpler way?"

## Anti-Patterns to Avoid

### ❌ Redundant Parameters
Don't add parameters to track what the system already knows:
```yaml
# BAD: Adding unnecessary parameters
inputs:
  isAutomated: true  # System already knows this
  triggerSource: "workflow"  # Context provides this
```

### ❌ Complex Conditionals
Don't create complex logic when simpler approaches exist:
```yaml
# BAD: Complex conditionals
if: always() && github.event_name == 'workflow_dispatch' && inputs.isAutomated != true
```

### ❌ Workarounds Instead of Proper Solutions
Don't use CLI calls when proper APIs exist:
```yaml
# BAD: Using CLI workarounds
run: gh workflow run other-workflow.yml -f param1=value1
```

### ❌ Multiple Ways to Do the Same Thing
Don't support multiple approaches for identical functionality:
```yaml
# BAD: Duplicate trigger types
on:
  workflow_dispatch: # Complex inputs
  workflow_call:     # Nearly identical inputs
```

## Better Approaches

### ✅ Use Built-in Context
```yaml
# GOOD: Use what the system provides
if: always() && github.event_name == 'workflow_dispatch'
```

### ✅ Use Proper Architecture
```yaml
# GOOD: Use workflow_call for automated calls
jobs:
  backup:
    uses: ./.github/workflows/wpengine-api-backup.yml
    with:
      installName: ${{ inputs.installName }}
    secrets: inherit
```

### ✅ Single Responsibility
```yaml
# GOOD: One workflow, one purpose
on:
  workflow_dispatch:
    inputs:
      installName:
        type: string
        required: true
```

## Decision Framework

Before adding complexity, ask:

1. **Does the system already provide this information?**
   - Check system context variables
   - Review platform documentation
   - Look for built-in capabilities

2. **Is there a simpler architectural approach?**
   - Can we use proper APIs instead of CLI?
   - Can we restructure to avoid the complexity?
   - Is there a more direct solution?

3. **Will this make maintenance harder?**
   - More parameters = more places for bugs
   - Complex conditionals = harder to debug
   - Multiple code paths = more testing needed

4. **What's the real requirement?**
   - Step back from the immediate problem
   - What are we actually trying to achieve?
   - Is there a different way to meet the requirement?

## Remember

- **The system is smarter than you think** - leverage built-in capabilities
- **Simple is maintainable** - fewer moving parts = fewer bugs
- **Architecture matters** - use the right tool for the job
- **When in doubt, ask** - "Is there a simpler way to do this?"

The best code is the code you don't have to write.