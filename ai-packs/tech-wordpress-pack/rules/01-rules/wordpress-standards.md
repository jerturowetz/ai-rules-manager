---
id: wordpress_standards
scope: domain
category: technology
description: "WordPress-specific coding standards, security practices, and development guidelines"
domains: ["wordpress", "php", "cms"]
tools_excluded: []
---

# WordPress Standards

Follow WordPress coding standards and security practices to ensure consistency, readability, and compatibility with the broader WordPress ecosystem.

## Coding Standards

### PHP Standards
- Use `phpcs` with the [WordPress Coding Standards (WPCS)](https://github.com/WordPress/WordPress-Coding-Standards)
- Use a project-level config file (e.g., `.phpcs.xml.dist`) to define and enforce standards
- Integrate WPCS into CI and editor tooling
- If using PHPStan or Psalm, configure them with WordPress-specific extensions and strict rules in files like `phpstan.neon`

### Code Organization
- Use WordPress APIs rather than direct database queries
- Follow theme/plugin development guidelines
- Implement proper hooks and filters
- Maintain backward compatibility when possible

## Security Practices

### Input Sanitization and Validation
- **Always sanitize input**: Use `sanitize_text_field()`, `sanitize_email()`, `wp_kses()`, etc.
- **Always validate data**: Check data types, ranges, and expected formats
- **Never trust user input**: Treat all input as potentially malicious

### Output Escaping
- **Always escape output**: Use `esc_html()`, `esc_attr()`, `esc_url()`, `wp_kses_post()`, etc.
- **Context-appropriate escaping**: Choose the right escaping function for where the data will be displayed
- **Escape late**: Sanitize input early, escape output late

### Database Security
- **Use prepared statements**: Always use `$wpdb->prepare()` for custom queries
- **Avoid direct SQL**: Use WordPress query functions when possible (`WP_Query`, `get_posts()`, etc.)
- **Validate database operations**: Check return values and handle errors appropriately

### Authentication and Authorization
- **Check user capabilities**: Use `current_user_can()` before sensitive operations
- **Use nonces**: Implement `wp_nonce_field()` and `wp_verify_nonce()` for form submissions
- **Validate user permissions**: Don't rely only on UI to restrict access

## WordPress-Specific Patterns

### Global Variables
- Avoid polluting the global namespace
- Use WordPress globals appropriately (`$wpdb`, `$wp_query`, etc.)
- Don't create unnecessary global variables

### Hooks and Filters
- Use semantic action and filter names
- Document custom hooks thoroughly
- Remove hooks when appropriate to prevent conflicts

### Enqueue Scripts and Styles
- Always use `wp_enqueue_script()` and `wp_enqueue_style()`
- Properly declare dependencies
- Use versioning for cache busting

## Tools

**Required:**
- [`phpcs`](https://github.com/squizlabs/PHP_CodeSniffer) - Code sniffer
- [`WordPress Coding Standards`](https://github.com/WordPress/WordPress-Coding-Standards) - WPCS ruleset

**Optional but Recommended:**
- [`phpstan-wordpress`](https://github.com/szepeviktor/phpstan-wordpress) - WordPress-specific static analysis

## Yoast SEO Redirects (When Applicable)

For regex redirects using `add_yoast_redirect`:

```php
// Preserve path segments
add_yoast_redirect('^/old-path/(.*)', 'new-path/$1', 301, 'regex');

// Specific path only
add_yoast_redirect('^/specific-page/?$', '/new-location/', 301, 'regex');
```

**Key components:**
- `^` – Start of string
- `(.*)` – Capture any remaining path segments
- `$1` – Reference to captured segments
- `301` – HTTP status code
- `'regex'` – Specify regex format