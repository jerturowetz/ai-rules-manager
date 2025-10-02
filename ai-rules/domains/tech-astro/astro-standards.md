---
id: astro_standards
scope: domain
category: technology
description: "Astro framework-specific development practices, performance optimization, and project structure guidelines"
domains: ["astro", "starlight", "javascript", "static_site"]
tools_excluded: []
---

# Astro Development Standards

Astro framework-specific development practices focusing on static generation, performance optimization, and proper project structure.

## Project Structure Standards

### Recommended Structure
```
src/
├── components/          # Reusable Astro components
│   └── starlight/      # Starlight component overrides
├── content/            # Processed content (auto-generated)
│   └── docs/          # Final MDX files for Starlight
├── content-src/       # Source content (protected)
│   ├── articles/      # Knowledge base articles
│   └── pages/        # Static pages
├── layouts/           # Page layouts
└── styles/           # Global styles
```

## Performance Guidelines

### Static Generation First
- **Prioritize static generation** over client-side JavaScript
- **Use client: directives sparingly** and only when needed:
  - `client:load` - Critical interactivity only
  - `client:idle` - Non-critical interactions
  - `client:visible` - Below-the-fold components

### Asset Optimization
- Use Astro's built-in image optimization
- Leverage lazy loading for images and assets
- Minimize bundle size through proper imports

## Development Practices

### Component Development
- Use `.astro` files for static components
- Pass data via `Astro.props`
- Implement proper component composition
- **ALWAYS use official components and patterns** from the framework rather than creating workarounds

### Content Management
- Follow the two-stage content workflow (source → processed → built)
- Use MDX for enhanced Markdown with components
- Leverage content collections for organization
- **Never edit processed content directly** - it gets overwritten

### TypeScript Usage
- Use TypeScript for type safety
- Implement proper error handling
- Follow Astro's TypeScript patterns

## Starlight-Specific Guidelines

### Component Integration
✅ **DO: Use Official Components**
```astro
import Header from 'virtual:starlight/components/Header';
import Footer from 'virtual:starlight/components/Footer';
import { LinkButton } from '@astrojs/starlight/components';
```

❌ **DON'T: Recreate Framework Functionality**
```astro
<!-- Don't duplicate built-in structures -->
<header class="sl-header">
  <div class="sl-header-content">...</div>
</header>
```

### Styling Hierarchy (in order of preference)

1. **Starlight built-in styles** - Use Starlight's CSS custom properties and theme variables
2. **Tailwind CSS classes** - Use Tailwind utility classes (included by default)
3. **Custom CSS (last resort)** - Only when built-ins and Tailwind are insufficient

### Tailwind CSS Compatibility
Use **pure CSS properties** instead of `@apply` directives in Astro component `<style>` blocks:

```css
/* ❌ DON'T: Use @apply in Astro <style> blocks */
<style>
    @layer starlight.core {
        .btn-primary {
            @apply px-4 py-2 text-sm font-medium rounded-md;
        }
    }
</style>

/* ✅ DO: Use equivalent CSS properties */
<style>
    @layer starlight.core {
        .btn-primary {
            padding: 0.5rem 1rem;          /* px-4 py-2 */
            font-size: 0.875rem;           /* text-sm */
            font-weight: 500;              /* font-medium */
            border-radius: 0.375rem;       /* rounded-md */
        }
    }
</style>
```

## Content Workflow Guidelines

### Two-Stage Content System
This project uses a **source-protection workflow**:

```
Source Content → Processed Content → Built Site
(protected)      (generated)        (output)
```

### Directory Structure
- `src/content-src/` - **SOURCE** (protected from overwrites)
- `src/content/docs/` - **PROCESSED** (auto-generated, do not edit directly)

### Workflow Commands
1. `npm run import` - Import from ZIP files to source
2. `npm run convert` - Convert source to processed content 
3. `npm run build` - Build final site

### ✅ DO:
- Edit files in `src/content-src/` for custom content
- Use the import/convert workflow for content updates
- Modify scripts to change processing behavior

### ❌ DON'T:
- Edit files directly in `src/content/docs/` (they get overwritten)
- Bypass the workflow system
- Assume content changes persist without running convert

## Module Standards

### ES Modules Preferred
- Use ES module (`import`/`export`) syntax instead of CommonJS
- Ensure `package.json` includes `"type": "module"` for Node.js projects
- Use `.mjs` extension when needed for module clarity

```js
// Good
import fs from 'fs';
export function processData() {}

// Bad
const fs = require('fs');
module.exports = processData;
```

## Documentation References

- **Main Astro Docs**: https://docs.astro.build/
- **Starlight Docs**: https://starlight.astro.build/
- **Component Overrides**: https://starlight.astro.build/guides/overriding-components/
- **CSS and Tailwind Guide**: https://starlight.astro.build/guides/css-and-tailwind/