---
id: code_formatting_guidelines
scope: global
category: formatting
description: "Specific formatting preferences for code blocks, headings, and document structure"
tools_excluded: []
---

# Code Formatting Guidelines

Use consistent formatting for code blocks, headings, and document structure.

## Code block formatting

- Use 4-space indentation for code blocks instead of triple backticks
- Single backticks are fine for inline code
- Maintain consistent indentation throughout code examples

## Code organization

- Define constant logic at the top of functions/modules, avoiding split logic between different control structures
- Keep related logic together rather than scattered across multiple conditional blocks
- Initialize variables and constants before using them in control flow

## Document structure

- Don't use '...' or '---' to divide sections unnecessarily
- Rely on proper heading structure for organization
- Don't bold headings (e.g., avoid `## **Heading**`)
- Use clean heading hierarchy without additional formatting

## Examples

✅ **Good code formatting:**

    function example() {
        const data = fetchData();
        return processData(data);
    }

✅ **Good logic organization:**

    function processUserData(users, filters) {
        // Define constants at the top
        const MAX_RESULTS = 100;
        const DEFAULT_SORT = 'name';
        const VALID_STATUSES = ['active', 'pending', 'inactive'];
        
        // Apply logic consistently
        const filteredUsers = users
            .filter(user => VALID_STATUSES.includes(user.status))
            .sort((a, b) => a[DEFAULT_SORT].localeCompare(b[DEFAULT_SORT]))
            .slice(0, MAX_RESULTS);
        
        return filteredUsers;
    }

❌ **Avoid scattered logic:**

    function processUserData(users, filters) {
        let results = [];
        for (let user of users) {
            const MAX_RESULTS = 100; // Don't define constants in loops
            if (user.status === 'active' || user.status === 'pending') {
                results.push(user);
            } else if (user.status === 'inactive') { // Split logic
                results.push(user);
            }
            if (results.length >= MAX_RESULTS) break;
        }
        return results;
    }

❌ **Avoid triple backticks for multi-line code**

✅ **Good heading structure:**

    # Main Heading
    ## Sub Heading
    ### Details

❌ **Avoid bolded headings:**

    ## **Sub Heading**
