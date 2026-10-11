# Implementation Plan

## Status

**Greenfield project.** The workspace contains only `spec.md`.
No existing framework, package manager, routes, components, styles, or deployment configuration exist.
Everything must be created from scratch.

---

## 1. Current Architecture

| Dimension | Current state |
|---|---|
| Framework | None |
| Package manager | None |
| Routes | None |
| Content system | None |
| Components | None |
| Styling system | None |
| Deployment configuration | None |
| Image handling | None |
| SEO implementation | None |
| GitHub Actions workflow | None |

The repository root contains a single file: `spec.md`.

---

## 2. Chosen Architecture

**Astro** is the mandatory framework.

Justification from `spec.md`:
- Explicitly names the reference repository as an Astro Blog Site (`divyavanmahajan/divyavanmahajan.github.io`).
- Lists Astro-specific patterns to follow: content collections, Astro architecture, static deployment, Markdown-first authoring.
- Requires `npm run dev`, `npm run build`, `npm run preview` — the standard Astro script set.
- Requires `dist/` as the build output — the Astro default.
- Prefers static generation and minimal JavaScript.

Astro is the correct and only reasonable choice for this project.

### Technology stack

| Concern | Decision |
|---|---|
| Framework | Astro (latest stable, `^5.x`) |
| Package manager | npm |
| Content | Astro Content Collections (Markdown files, `src/content/blog/`) |
| Styling | Vanilla CSS (custom properties, no Tailwind, no CSS framework) |
| Search | Client-side, vanilla JS (lightweight, acceptable for small blog per spec) |
| Syntax highlighting | Astro built-in (Shiki via `@astrojs/markdown-remark`) |
| Images | Astro built-in `<Image />` component (`astro:assets`) for `src/assets/`; plain `<img>` for `public/` |
| Deployment | GitHub Pages via GitHub Actions |
| Fonts | Google Fonts (Open Sans, Inter, IBM Plex Mono) + system serif for site title |

---

## 3. Required Changes

Since this is greenfield, all work is creation, not modification.

### Phase 1 — Project scaffold

Initialize Astro project in the workspace root:

```
npx create-astro@latest ./ --template minimal --no-git --typescript strict --install
```

This produces: `package.json`, `astro.config.mjs`, `tsconfig.json`, `src/`, `.gitignore`.

### Phase 2 — Configuration

Configure `astro.config.mjs`:
- `output: 'static'`
- `site:` set to the GitHub Pages URL
- Enable `@astrojs/sitemap` integration
- Configure `markdown.shikiConfig` for code block syntax highlighting

### Phase 3 — Content schema

Define Content Collection schema in `src/content/config.ts`:

```ts
const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    author: z.string(),
    categories: z.array(z.string()),
    tags: z.array(z.string()),
    draft: z.boolean().default(false),
    heroImage: z.string().optional(),
    heroImageAlt: z.string().optional(),
  }),
});
```

### Phase 4 — Layouts and components

Create all layouts and components (see Section 5).

### Phase 5 — Article content

Create the VPN article Markdown file with frontmatter and body content.

### Phase 6 — Diagrams

Generate four technical diagrams as `.webp` files placed in `public/images/blog/site-to-site-vpn/`.

### Phase 7 — SEO and metadata

Wire the `<BaseHead />` component into all layouts.

### Phase 8 — GitHub Actions

Create `.github/workflows/deploy.yml` for GitHub Pages deployment.

### Phase 9 — Verification

Run `npm install`, `npm run build`, `npm run preview` and confirm all spec quality requirements are met.

---

## 4. Files to Create

### Root

```
package.json                      — Astro project, scripts: dev/build/preview
astro.config.mjs                  — Static output, site URL, integrations
tsconfig.json                     — Astro strict TypeScript config
.gitignore                        — node_modules, dist/, .astro/
README.md                         — Project description
```

### Source — Content

```
src/content/config.ts                                   — Blog collection schema
src/content/blog/2026/10/site-to-site-vpn.md            — The VPN article (Markdown + frontmatter)
```

### Source — Layouts

```
src/layouts/BaseLayout.astro        — HTML shell: <head>, <header>, <footer>, slots
src/layouts/BlogPostLayout.astro    — Article layout: two-column (content + sidebar)
src/layouts/IndexLayout.astro       — Homepage layout
```

### Source — Components

```
src/components/BaseHead.astro          — <title>, meta, canonical, OG, Twitter card
src/components/Header.astro            — Site name + navigation (Home, Categories, Tags, About)
src/components/Footer.astro            — Minimal footer
src/components/PostCard.astro          — Homepage post card (title, desc, date, category, tags, hero)
src/components/Sidebar.astro           — Desktop sidebar (search, TOC, recent posts, categories, tags)
src/components/TableOfContents.astro   — Article TOC from headings
src/components/Search.astro            — Lightweight client-side search (vanilla JS)
src/components/TagList.astro           — Reusable tag pill list
src/components/CategoryBadge.astro     — Reusable category badge
```

### Source — Pages

```
src/pages/index.astro                          — Homepage (site intro + recent posts)
src/pages/posts/[...slug].astro                — Dynamic article route
src/pages/categories/index.astro               — All categories listing
src/pages/categories/[category].astro          — Posts filtered by category
src/pages/tags/index.astro                     — All tags listing
src/pages/tags/[tag].astro                     — Posts filtered by tag
src/pages/about.astro                          — About page
src/pages/404.astro                            — Custom 404 page
```

### Source — Styles

```
src/styles/global.css              — CSS custom properties, reset, typography, base styles
src/styles/article.css             — Article prose styles (code blocks, tables, blockquotes)
src/styles/sidebar.css             — Sidebar and search styles
```

### Public — Images

```
public/images/blog/site-to-site-vpn/site-to-site-vpn-hero.webp
public/images/blog/site-to-site-vpn/vpn-site-to-site-architecture.webp
public/images/blog/site-to-site-vpn/vpn-packet-encapsulation.webp
public/images/blog/site-to-site-vpn/vpn-packet-journey.webp
public/images/blog/site-to-site-vpn/vpn-complete-model.webp
```

### Public — Other

```
public/favicon.svg                 — Simple favicon
public/robots.txt                  — Allow all crawlers
```

### GitHub Actions

```
.github/workflows/deploy.yml       — Build and deploy to GitHub Pages
```

### Docs

```
docs/implementation-plan.md        — This document
```

---

## 5. Files to Modify

None. This is a greenfield project.
`spec.md` is a read-only reference — do not modify it.

---

## 6. Files That Must Not Be Touched

| File | Reason |
|---|---|
| `spec.md` | Authoritative requirements document — read-only |

---

## 7. Content Architecture

### Collection

- **Type:** Astro Content Collections v2 (`src/content/blog/`)
- **Nesting:** Year/month subdirectories for organisation (`2026/10/`)
- **No CMS, no database, no backend** — purely file-based

### Frontmatter schema

```yaml
title: "Site-to-Site VPN: How Two Private Networks Connect Securely Over the Internet"
description: "A technical introduction to Site-to-Site VPN, covering fundamentals,
  packet flow, IPsec, IKEv2, ESP, encryption, authentication, and real-world applications."
pubDate: 2026-10-08
author: "Author Name"
categories:
  - Networking
tags:
  - VPN
  - IPsec
  - IKEv2
  - Networking
  - Security
draft: false
heroImage: /images/blog/site-to-site-vpn/site-to-site-vpn-hero.webp
heroImageAlt: "Diagram showing two corporate offices connected by a Site-to-Site VPN tunnel over the internet"
```

### URL structure

- Article:    `/posts/site-to-site-vpn-how-two-private-networks-connect-securely/`
- Categories: `/categories/networking/`
- Tags:       `/tags/vpn/`

The dynamic route `src/pages/posts/[...slug].astro` maps the file slug to the spec-mandated URL via `getStaticPaths()`.

### Diagram placement (from spec)

| Diagram | Placement in article |
|---|---|
| `vpn-site-to-site-architecture.webp` | Immediately after the explanation of Site-to-Site VPN |
| `vpn-packet-encapsulation.webp` | Immediately after explaining packet protection and encapsulation |
| `vpn-packet-journey.webp` | Immediately after explaining the complete packet journey |
| `vpn-complete-model.webp` | Near the end, as the final visual summary |

### Adding new posts (workflow per spec)

1. Create `src/content/blog/YYYY/MM/post-slug.md`
2. Add frontmatter (title, description, pubDate, author, categories, tags, draft)
3. Add images to `public/images/blog/<post-slug>/`
4. `npm run build`
5. Push to GitHub

---

## 8. Image Architecture

### Storage location

```
public/images/blog/<article-slug>/<image-name>.webp
```

Images in `public/` are copied verbatim to `dist/` by Astro.

### Format

All article images use **WebP** as specified. Benefits: smaller files vs PNG/JPEG, wide browser support.

### Hero image

- Dimensions: ~1200×630px (optimal for OG image)
- Rendered with `loading="eager"` (above the fold)
- Used as the OG image in `<BaseHead />`

### Diagram images

- Rendered with `loading="lazy"` and explicit `width` + `height` attributes
- Each has a descriptive `alt` attribute
- Wrapped in `<figure>` with `<figcaption>`

### Responsive constraint

```css
img, figure, pre, table {
  max-width: 100%;
}
pre, code {
  overflow-x: auto;
}
```

This prevents horizontal overflow on mobile per spec requirement.

---

## 9. SEO Implementation

### `<BaseHead />` component outputs

| Tag | Value source |
|---|---|
| `<title>` | `title` prop + ` | Blog Name` suffix |
| `<meta name="description">` | `description` prop |
| `<link rel="canonical">` | `Astro.url.href` or explicit `canonicalURL` prop |
| `<meta property="og:title">` | `title` prop |
| `<meta property="og:description">` | `description` prop |
| `<meta property="og:image">` | `heroImage` prop or default OG image |
| `<meta property="og:url">` | Canonical URL |
| `<meta property="og:type">` | `article` for posts, `website` for index pages |
| `<meta name="twitter:card">` | `summary_large_image` |
| `<meta name="twitter:title">` | `title` prop |
| `<meta name="twitter:description">` | `description` prop |
| `<meta name="twitter:image">` | `heroImage` prop or default OG image |

### Structural SEO

- Semantic HTML5: `<header>`, `<nav>`, `<main>`, `<article>`, `<aside>`, `<footer>`
- Single `<h1>` per page (article title on article pages; site tagline on homepage)
- `<h2>` through `<h4>` for article sections
- Clean trailing-slash URLs via Astro static routing
- `@astrojs/sitemap` generates `sitemap-index.xml` automatically at build time
- `robots.txt` allows all crawlers

### Article canonical URL (from spec)

```
/posts/site-to-site-vpn-how-two-private-networks-connect-securely/
```

---

## 10. Responsive Design Approach

### Breakpoints

| Name | Width |
|---|---|
| Mobile | `< 768px` |
| Tablet | `768px – 1024px` |
| Desktop | `> 1024px` |

### Layout strategy

**Desktop (> 1024px):**
- CSS Grid: `1fr 300px` (content flexible, sidebar 280–320px)
- Max site width: `1200px`, centred with `margin: 0 auto`
- Sidebar: search, TOC, recent posts, categories, tags — always visible

**Tablet (768px – 1024px):**
- Single-column layout
- Sidebar content moves below article body

**Mobile (< 768px):**
- Single-column, full width
- Sidebar appended below article
- Header nav collapses via `<details>/<summary>` (no-JS hamburger)
- `overflow-x: hidden` on `<body>`
- Code blocks: `overflow-x: auto` (horizontal scroll within block only)
- Images: `max-width: 100%`

### CSS design tokens

```css
:root {
  /* Palette from spec */
  --color-bg:             #F7F7F7;
  --color-surface:        #FFFFFF;
  --color-text:           #111111;
  --color-text-secondary: #555555;
  --color-accent:         #E22D30;
  --color-border:         #E6E6E6;

  /* Typography */
  --font-serif:   "Times New Roman", Georgia, serif;
  --font-sans:    "Inter", system-ui, sans-serif;
  --font-heading: "Open Sans", system-ui, sans-serif;
  --font-mono:    "IBM Plex Mono", "Courier New", monospace;

  /* Layout */
  --max-width:      1200px;
  --sidebar-width:  300px;
  --content-max:    72ch;

  /* Sizing */
  --body-font-size: 17px;
  --line-height:    1.75;
}
```

### Typography scale (matches spec)

- Body: 16–17px, Inter, line-height 1.75
- Headings: Open Sans Bold
- Site title: Times New Roman (or system serif)
- Code: IBM Plex Mono, 14px

---

## 11. Deployment Approach

### Platform

GitHub Pages (static hosting, free for public repos).

### GitHub Actions workflow

**Trigger:** push to `main` branch or manual `workflow_dispatch`.

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
      - run: npm ci
      - run: npm run build
      - uses: actions/upload-pages-artifact@v3
        with:
          path: dist/

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deploy.outputs.page_url }}
    steps:
      - uses: actions/deploy-pages@v4
        id: deploy
```

### `astro.config.mjs` key settings

```js
export default defineConfig({
  site: 'https://<username>.github.io',
  // base: '/<repo-name>',  // only for project pages
  output: 'static',
  integrations: [sitemap()],
});
```

### GitHub repository settings required

- Settings > Pages > Source: **GitHub Actions** (not `gh-pages` branch)
- No other special configuration needed

---

## 12. Testing Strategy

No automated test suite. Manual verification against the spec checklist.

### Build-time verification (automatic)

`npm run build` provides:
- TypeScript type checking
- Content Collection schema validation (missing/wrong frontmatter fields = build error)
- Broken component imports = build error
- Missing page routes = build error

### Manual pre-push checklist

| Requirement | Verification method |
|---|---|
| `npm install` succeeds | Run locally, zero errors |
| `npm run build` succeeds | Zero Astro build errors |
| `npm run preview` succeeds | Site loads at `http://localhost:4321` |
| Article renders correctly | Navigate to `/posts/site-to-site-vpn-how-two-private-networks-connect-securely/` |
| Images load | DevTools Network tab — zero 404s |
| Mobile layout works | DevTools responsive mode at 375px |
| Desktop layout works | DevTools at 1280px, sidebar visible |
| Navigation works | Click Home, Categories, Tags, About — all resolve |
| Search works | Type in search box, confirm results filter |
| Table of contents works | Click TOC headings, verify scroll-to-section |
| Metadata exists | View source, confirm `<title>`, OG, Twitter tags |
| No broken links | Click all internal links, zero 404s |
| No console errors | DevTools Console — zero errors |
| No horizontal overflow | Mobile viewport — no horizontal scrollbar |
| Images have alt text | Inspect each `<img>` — `alt` present and descriptive |
| GitHub Pages deployment succeeds | Actions workflow green, URL resolves |

### Accessibility spot-checks

| Check | Method |
|---|---|
| Keyboard navigation | Tab through all interactive elements |
| Heading hierarchy | Browser accessibility tree |
| Colour contrast (body text) | `#111111` on `#FFFFFF` = 21:1 (WCAG AAA) |
| Colour contrast (secondary text) | `#555555` on `#FFFFFF` = 7.6:1 (WCAG AAA) |
| Alt text | Inspect all images |
| Link states | Verify `:hover`, `:focus`, `:visited` styles |
| Skip link | Confirm "Skip to content" link at top of page |

---

## 13. Ambiguities

The following are not specified in `spec.md` and require either clarification or a stated assumption.

### A1 — GitHub repository type (user page vs. project page)

**Impact:** Determines `base` path in `astro.config.mjs` and all internal URLs.

- User page (`<username>.github.io`): `base` omitted, site at `https://<username>.github.io`
- Project page (any other repo name): `base: '/<repo-name>/'`, site at `https://<username>.github.io/<repo-name>/`

**Default assumption:** User page. Must be confirmed before first deploy.

---

### A2 — GitHub username and final site URL

The spec says "USER'S OWN GITHUB REPOSITORY" without naming the user or repo.

**Impact:** `site:` field in `astro.config.mjs`, canonical URLs, OG image URLs, sitemap.

**Default assumption:** Placeholder `https://example.github.io` used during development. Must be replaced.

---

### A3 — Author name

The `author` frontmatter field is required by the schema but no name is provided in `spec.md`.

**Default assumption:** `"Author"` placeholder in the article frontmatter. Must be replaced.

---

### A4 — Article body content

`spec.md` says *"Use the complete article supplied separately."* No article body is present in the repository.

**Impact:** The VPN article cannot be completed without the body text.

**Resolution required:** Article body must be supplied. The implementation plan assumes it will be provided and written at implementation time, following the technical accuracy rules in `spec.md` (correct VPN/IPsec/IKEv2/ESP terminology, no "physical tunnel" claims).

---

### A5 — Search implementation

No specific library named. Spec says "lightweight" and "client-side is acceptable."

**Chosen approach:** Vanilla JS search against a pre-built JSON index generated at Astro build time.
No external library (no Pagefind, no Fuse.js). Revisit if post count exceeds ~50.

---

### A6 — Mobile navigation pattern

Spec requires keyboard-accessible navigation but does not specify hamburger vs. always-visible.

**Chosen approach:** `<details>`/`<summary>` hamburger — works without JavaScript, natively keyboard accessible.

---

### A7 — Table of contents scope

TOC is listed in both the Article Page requirements and the Sidebar requirements. Unclear if TOC appears only in the sidebar or also inline in the article on mobile.

**Chosen approach:** TOC in sidebar on desktop. On mobile (sidebar collapses below), a compact TOC appears inline at the top of the article body.

---

### A8 — Diagram production method

Spec specifies four `.webp` diagram files but does not specify how they are produced (illustrations, SVG exports, photos, etc.).

**Chosen approach:** Generate as styled technical diagrams using AI image generation. Each diagram will accurately represent the VPN/networking concepts described in the spec.

---

## 14. Summary

This is a complete greenfield build. No existing code to preserve or migrate.

**Core implementation tasks (in order):**

1. Scaffold Astro project with static output
2. Configure `astro.config.mjs` with site URL, sitemap, and Shiki
3. Define Content Collection schema (`src/content/config.ts`)
4. Build `global.css` with design tokens matching spec palette and typography
5. Build layouts: `BaseLayout`, `BlogPostLayout`, `IndexLayout`
6. Build components: `BaseHead`, `Header`, `Footer`, `PostCard`, `Sidebar`, `TableOfContents`, `Search`, `TagList`, `CategoryBadge`
7. Build pages: index, article route, categories, tags, about, 404
8. Write VPN article in Markdown with full frontmatter
9. Generate 5 WebP images (1 hero + 4 diagrams)
10. Create GitHub Actions workflow
11. Verify all 16 quality requirements from spec

**No unnecessary dependencies.** Only `@astrojs/sitemap` added beyond core Astro.
`spec.md` is never modified.
