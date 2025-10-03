---
id: systematic_file_operations
scope: global
category: workflow
description: "Always follow systematic validation approach for bulk file operations, especially potentially destructive ones"
tools_excluded: []
---

# Systematic File Operations with Validation

When performing bulk file operations (especially potentially destructive ones like deleting files), always follow a systematic validation approach to minimize data loss risk.

## Core principles

### Test small first
- **Always** start with a single file or small subset before bulk operations
- Validate the process works correctly on the test case
- Only proceed to bulk operations after successful validation

### Non-interactive operations
- Use appropriate flags to avoid interactive prompts in automated scripts
- Handle edge cases programmatically rather than requiring user input
- Examples: `-o` (overwrite), `-j` (junk paths), `-q` (quiet) for unzip operations

### Verification before deletion
- Never delete source files until extraction/operation is completely verified
- Check file counts, checksums, or other validation metrics
- Provide clear success/failure indicators

### Graceful error handling
- Check for common issues: disk space, permissions, file corruption
- Provide meaningful error messages
- Fail safely - prefer keeping original files over risky deletions

## Implementation pattern

    #!/bin/bash
    # Template for systematic file operations
    
    # 1. Pre-flight checks
    check_disk_space
    check_permissions
    validate_input_files
    
    # 2. Test with single file
    process_single_file_test()
    
    # 3. If test succeeds, process all files
    for file in files; do
        if process_file "$file"; then
            verify_operation "$file"
            if verification_passed; then
                cleanup_source_file "$file"
            else
                log_warning "Verification failed for $file"
            fi
        else
            log_error "Processing failed for $file"
        fi
    done
    
    # 4. Final verification and summary
    generate_operation_report

## Error recovery

- Keep detailed logs of all operations
- Provide rollback mechanisms where possible
- Never assume operations succeeded without verification

## Common use cases

- Bulk file extraction/compression
- File format conversions
- Data migrations
- Batch file processing

## Why this matters

This systematic approach ensures reliable, predictable file operations while minimizing the risk of data loss through premature deletion or incomplete processing.