---
id: api_incremental_testing
scope: global
category: testing
description: "Always test API changes with small datasets before running on full data to prevent mass errors"
tools_excluded: []
---

# API Incremental Testing

When making changes to API interactions, always test incrementally before processing large datasets.

## Core Principle

**Test small, then scale.** Never run modified API code against your entire dataset without validating the changes first.

## Testing Approach

### 1. Single Item Test
```bash
# Test with ONE item first
process_api_data --limit=1

# Verify the result manually
# Check logs, response format, error handling
```

### 2. Small Batch Test
```bash
# Test with a tiny subset (5-10 items)
process_api_data --limit=10

# Validate:
# - No unexpected errors
# - Response format is correct
# - Rate limiting works properly
# - Error handling behaves as expected
```

### 3. Gradual Scale-Up
```bash
# Only after small tests pass
process_api_data --limit=100   # Medium test
process_api_data               # Full dataset
```

## Why This Matters

### ✅ **Prevents Mass Failures:**
- API rate limiting issues discovered early
- Data format changes caught before corrupting large datasets
- Authentication problems identified quickly
- Network timeouts handled before affecting thousands of records

### ✅ **Saves Time:**
- Fix issues on 1 record vs. debugging 10,000 failed records
- Avoid API quota exhaustion from repeated failed requests
- Prevent data corruption requiring full rollback

### ✅ **Reduces Costs:**
- Many APIs charge per request - failed mass operations are expensive
- Prevents hitting rate limits that require waiting periods
- Avoids cleanup work from partial failures

## Implementation Examples

### API Client Changes
```python
# ❌ Don't do this
for item in all_10000_items:
    api_client.process(item)  # Untested changes

# ✅ Do this instead
test_items = all_items[:1]  # Test with 1 item first
for item in test_items:
    result = api_client.process(item)
    print(f"Test result: {result}")  # Verify manually

# After verification, proceed with full dataset
```

### Database Operations
```bash
# ❌ Don't run untested changes on full table
UPDATE users SET new_column = api_fetch(user_id);

# ✅ Test with LIMIT first
UPDATE users SET new_column = api_fetch(user_id) LIMIT 5;
-- Check results manually
-- Then proceed with full update
```

## Red Flags

Stop and test incrementally when you:
- Modified API request format or parameters
- Changed authentication or headers
- Updated error handling logic
- Switched API endpoints or versions
- Added new data processing steps
- Changed rate limiting or retry logic

**Remember: It's always faster to test 1 record properly than to debug 1,000 failed records.**