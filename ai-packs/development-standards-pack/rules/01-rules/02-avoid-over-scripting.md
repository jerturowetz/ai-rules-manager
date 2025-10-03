---
id: avoid_over_scripting
scope: global
category: efficiency
description: "Don't write scripts for simple tasks that can be done manually - especially for small datasets"
tools_excluded: []
---

# Avoid Over-Scripting

You don't need to automate everything. Sometimes manual inspection and decision-making is faster and more appropriate than writing a script.

## Core Principle

**Script when it saves time, not when it feels sophisticated.** Manual work is often faster for small, one-time tasks.

## When NOT to Write Scripts

### Small File Counts
```bash
# ❌ Don't write a Python script for this
ls project_files/
# Only 5 files? Just look at them manually
cat file1.txt  # Quick manual review
cat file2.txt
```

### One-Time Operations
```bash
# ❌ Don't script this
# "Write a script to check these 3 config files for syntax errors"

# ✅ Just do this
yamllint config1.yaml
yamllint config2.yaml  
yamllint config3.yaml
```

### Simple Decision Trees
```bash
# ❌ Don't script complex logic for
ls uploads/ | wc -l  # 7 files

# ✅ Just manually check each file
file uploads/doc1.pdf  # "PDF document, version 1.4"
file uploads/img2.jpg  # "JPEG image data"
# Make decisions based on what you see
```

## When TO Write Scripts

### High Volume
```bash
# ✅ Script makes sense here
find /logs -name "*.log" | wc -l  # 15,000 files
# Yes, write a script to process these
```

### Repeated Operations
```bash
# ✅ You'll do this weekly
# Write a script for recurring tasks
```

### Complex Logic
```bash
# ✅ Multi-step validation across many files
# Write a script when manual steps would be error-prone
```

## Decision Framework

Ask yourself:

1. **How many items?** 
   - < 10 items → Probably manual
   - > 50 items → Probably script
   - 10-50 items → Depends on complexity

2. **How often will this run?**
   - Once → Probably manual
   - Weekly → Probably script
   - Occasionally → Depends on complexity

3. **How complex is the logic?**
   - Simple check → Manual
   - Multi-step validation → Script
   - Complex conditionals → Script

## Examples

### ✅ **Good Manual Approach:**
```bash
# Task: "Check if these 5 API endpoints are responding"
curl -I https://api1.example.com/health
curl -I https://api2.example.com/health  
curl -I https://api3.example.com/health
curl -I https://api4.example.com/health
curl -I https://api5.example.com/health
```

### ❌ **Over-Scripted:**
```python
#!/usr/bin/env python3
import requests
import concurrent.futures
from typing import List

def check_endpoints(urls: List[str]) -> dict:
    """Check health of multiple endpoints with threading and error handling..."""
    # 30 lines of code for something that takes 30 seconds manually
```

### ✅ **Good Scripted Approach:**
```bash
# Task: "Check if these 100 log files contain errors"
# This many files? Script makes sense.
find /logs -name "*.log" -exec grep -l "ERROR" {} \;
```

## Red Flags for Over-Scripting

Stop and consider manual approach when:
- Writing more than 10 lines for a one-time task
- Spending more time writing the script than doing the task manually
- Adding error handling for edge cases that won't occur in your specific use case
- Creating reusable functions for something you'll never reuse

## Time Investment Guide

**5-minute rule**: If the manual task takes less than 5 minutes and you won't repeat it soon, don't script it.

**Script time vs. execution time**: If writing the script takes longer than doing the task manually × number of times you'll do it, don't script it.

## Remember

- **Efficiency over elegance** - Choose the approach that gets you to the result fastest
- **Manual doesn't mean sloppy** - You can still be systematic and thorough
- **Scripts aren't always better** - They introduce complexity, debugging, and maintenance overhead

**Sometimes `ls` and your eyes are the best tools for the job.**