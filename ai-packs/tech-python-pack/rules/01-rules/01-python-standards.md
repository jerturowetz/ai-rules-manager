---
id: python_standards
scope: domain
category: technology
description: "Python-specific coding standards following PEP 8 and modern best practices"
domains: ["python", "data_science", "automation"]
tools_excluded: []
---

# Python Coding Standards

Follow PEP 8 and Python best practices for consistent, maintainable, and professional code.

## Code Style

### Indentation and Line Length
- Use **4 spaces** for indentation (no tabs)
- Maximum line length of **88 characters** (Black formatter style)
- Use parentheses for line continuation when needed

### Naming Conventions
- **snake_case** for functions and variables: `process_data()`, `user_name`
- **PascalCase** for classes: `DataProcessor`, `UserManager`
- **UPPER_CASE** for constants: `MAX_RETRY_COUNT`, `DEFAULT_TIMEOUT`
- **Private attributes**: prefix with single underscore `_private_method()`
- **Strongly private**: prefix with double underscore `__internal_attr`

### Import Organization
```python
# Standard library imports
import os
import sys
from typing import Dict, List, Optional

# Third-party imports
import requests
import pandas as pd

# Local application imports
from .models import User
from .utils import helper_function
```

## Documentation

### Docstrings
Use Google-style docstrings for all functions, classes, and modules:

```python
def process_data(data: List[Dict], threshold: float = 0.5) -> Dict:
    """Process raw data and filter based on threshold.
    
    Args:
        data: List of dictionaries containing raw data points
        threshold: Minimum value threshold for filtering (default: 0.5)
    
    Returns:
        Dictionary containing processed results and metadata
    
    Raises:
        ValueError: If data is empty or threshold is negative
    """
    pass
```

### Type Hints
- Use type hints for all function signatures
- Import from `typing` when needed: `List`, `Dict`, `Optional`, `Union`
- Use `Optional[Type]` for parameters that can be `None`

```python
from typing import List, Optional, Dict, Union

def analyze_results(
    data: List[Dict[str, Union[str, int]]], 
    config: Optional[Dict[str, str]] = None
) -> Dict[str, float]:
    pass
```

## Error Handling

### Exception Handling
- Use **specific exception types**, not bare `except:`
- Handle exceptions at the appropriate level
- Provide meaningful error messages

```python
# Good
try:
    result = api_call()
except requests.RequestException as e:
    logger.error(f"API request failed: {e}")
    raise ProcessingError("Failed to fetch data from API")

# Bad
try:
    result = api_call()
except:
    pass
```

### Notion API Error Handling (When Applicable)
- Handle Notion API errors gracefully with appropriate fallbacks
- Use exponential backoff for rate limiting
- Log errors with context for debugging

```python
import time
from notion_client import APIResponseError

def safe_notion_query(notion, **query_params):
    max_retries = 3
    for attempt in range(max_retries):
        try:
            return notion.databases.query(**query_params)
        except APIResponseError as e:
            if e.status == 429:  # Rate limited
                wait_time = 2 ** attempt
                time.sleep(wait_time)
            else:
                raise
    raise Exception(f"Failed after {max_retries} attempts")
```

## Environment and Dependencies

### Virtual Environments
- Always use virtual environments (`venv`, `conda`, or `poetry`)
- Never install packages globally for project work
- Include `requirements.txt` or `pyproject.toml`

### Environment Variables
- Use `python-dotenv` for local development
- Never commit secrets to version control
- Use `.env.example` to document required variables

```python
from dotenv import load_dotenv
import os

load_dotenv()

API_KEY = os.getenv('NOTION_API_KEY')
if not API_KEY:
    raise ValueError("NOTION_API_KEY environment variable is required")
```

## Testing

### Test Structure
- Use `pytest` for testing framework
- Organize tests in `tests/` directory
- Use descriptive test names: `test_should_return_empty_dict_when_no_data()`

### Test Coverage
- Aim for high test coverage (>80%)
- Test both success and failure cases
- Mock external dependencies

## Performance and Best Practices

### General Guidelines
- Use list comprehensions for simple transformations
- Prefer `pathlib` over `os.path` for file operations
- Use context managers (`with` statements) for resource management
- Avoid global variables

### Data Processing
- Use `pandas` for data manipulation when appropriate
- Consider memory usage for large datasets
- Use generators for memory-efficient iteration

```python
# Memory efficient
def process_large_file(filepath: Path) -> Iterator[Dict]:
    with open(filepath) as f:
        for line in f:
            yield process_line(line)

# Instead of loading everything into memory
def load_all_data(filepath: Path) -> List[Dict]:
    with open(filepath) as f:
        return [process_line(line) for line in f]  # Could use too much memory
```