# Project Specification

## Project

A personal technical blog for a Computer Engineering student.

The first featured article is:

"Site-to-Site VPN: How Two Private Networks Connect Securely Over the Internet"

The website must be lightweight, responsive, fast, accessible, and easy to maintain.

---

## Primary Goal

Create a professional technical blog where long-form Computer Science and Computer Engineering articles can be published as Markdown.

The first article must teach Site-to-Site VPN from fundamentals through packet flow, routing, IPsec, authentication, encryption, and real-world applications.

---

## Target Audience

Primary:

- Computer Engineering students
- Computer Science students
- Networking students
- Beginners learning Computer Networks

Secondary:

- Junior developers
- IT students
- Technical readers

The writing must be technically accurate but understandable without assuming professional networking experience.

---

## Design Direction

Use the provided reference repository as an architectural and information-design reference:

https://github.com/divyavanmahajan/divyavanmahajan.github.io/

Do NOT copy its source code, text, branding, assets, or exact visual design.

Use the reference for:

- Markdown-first authoring
- Astro architecture
- Content collections
- Header/navigation
- Sidebar
- Table of contents
- Categories
- Tags
- Search
- Responsive article layout
- Static deployment
- Separation of content and UI

---

## Visual Design

Create an original visual identity.

Design characteristics:

- Technical
- Minimal
- Academic
- Editorial
- Professional
- High readability

Avoid:

- Generic AI dashboard design
- Excessive gradients
- Glassmorphism
- Excessive animations
- Huge rounded cards
- Neon cyberpunk styling
- Stock photography
- Decorative elements that don't communicate information

Preferred palette:

Background:
#F7F7F7

Surface:
#FFFFFF

Text:
#111111

Secondary:
#555555

Primary accent:
#E22D30

Border:
#E6E6E6

---

## Typography

Site title:
Times New Roman or another restrained serif.

Headings:
Open Sans, bold.

Body:
Inter or equivalent highly readable sans-serif.

Code:
IBM Plex Mono or another readable monospace font.

Body text should be approximately 16–18px.

Article line-height should be approximately 1.7–1.8.

---

## Layout

Desktop:

Main content + right sidebar.

Approximate:

Content: flexible
Sidebar: 280–320px

Maximum site width:
1200px.

Mobile:

Single-column layout.

Sidebar moves below article or becomes collapsible.

No horizontal page overflow.

Code blocks and diagrams must remain inside the viewport.

---

## Header

Include:

Site name
Home
Categories
Tags
About

Keep navigation simple.

---

## Homepage

Homepage must contain:

- Site introduction
- Recent posts
- Post title
- Description
- Publication date
- Category
- Tags
- Optional thumbnail/hero image

---

## Article Page

Article page must contain:

1. Title
2. Description
3. Author
4. Publication date
5. Hero image
6. Table of contents
7. Article content
8. Technical diagrams
9. Tags
10. References

The article should have comfortable reading width.

---

## Sidebar

Desktop sidebar should contain:

- Search
- Table of contents or article navigation where appropriate
- Recent posts
- Categories
- Tags

Search should be lightweight.

For a small blog, client-side search is acceptable.

---

## Article

Create:

src/content/blog/2026/10/site-to-site-vpn.md

Use the complete article supplied separately.

Frontmatter:

title:
description:
pubDate:
author:
categories:
tags:
draft:

---

## Article Diagrams

The article requires four major diagrams:

1. Site-to-Site VPN Architecture
2. Packet Encapsulation
3. End-to-End Packet Journey
4. Complete VPN Model

Store them in:

public/images/blog/site-to-site-vpn/

Use descriptive filenames:

vpn-site-to-site-architecture.webp
vpn-packet-encapsulation.webp
vpn-packet-journey.webp
vpn-complete-model.webp

Hero:

site-to-site-vpn-hero.webp

All images require descriptive alt text.

---

## Diagram Placement

Diagram 1:
Immediately after the explanation of Site-to-Site VPN.

Diagram 2:
Immediately after explaining packet protection and encapsulation.

Diagram 3:
Immediately after explaining the complete packet journey.

Diagram 4:
Near the end as the final visual summary.

---

## Technical Accuracy

Do not invent networking terminology.

The article must correctly distinguish:

- VPN
- Site-to-Site VPN
- Remote-Access VPN
- VPN gateway
- Tunnel
- Routing
- IPsec
- IKEv2
- ESP
- Encryption
- Authentication
- Encapsulation
- Decapsulation

Do not claim that VPN creates a physical tunnel.

Do not claim that VPN automatically makes every internal device trusted.

Do not claim that encryption alone constitutes the complete VPN architecture.

---

## SEO

Every article needs:

- title
- meta description
- canonical URL
- Open Graph title
- Open Graph description
- Open Graph image
- Twitter/X card metadata

Use semantic HTML.

Generate clean URLs.

Article URL:

/posts/site-to-site-vpn-how-two-private-networks-connect-securely/

---

## Accessibility

All images need alt text.

Navigation must be keyboard accessible.

Color contrast must be sufficient.

Links must have recognizable states.

Do not rely only on color to communicate meaning.

---

## Performance

Prefer static generation.

Avoid unnecessary JavaScript.

Do not add large UI frameworks unless required.

Images should be optimized.

Lazy-load non-hero images.

---

## Deployment

Primary deployment:

GitHub Pages.

Repository:

USER'S OWN GITHUB REPOSITORY

Use GitHub Actions.

Build:

npm run build

Output:

dist/

The project should work with:

npm run dev
npm run build
npm run preview

---

## Maintainability

New blog posts should require only:

1. Create Markdown file.
2. Add frontmatter.
3. Add images if required.
4. Run build.
5. Push to GitHub.

Do not introduce a CMS.

Do not require a database.

Do not require a backend.

---

## Final Quality Requirements

Before considering the project complete:

- npm install succeeds
- npm run build succeeds
- npm run preview succeeds
- Article renders correctly
- Images load
- Mobile layout works
- Desktop layout works
- Navigation works
- Search works
- Table of contents works
- Metadata exists
- No broken links
- No console errors
- No horizontal overflow
- Images have alt text
- GitHub Pages deployment succeeds