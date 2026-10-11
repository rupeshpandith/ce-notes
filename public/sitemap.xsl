<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sm="http://www.sitemaps.org/schemas/sitemap/0.9">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes" />

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>XML Sitemap | CE Notes</title>
        <style>
          :root {
            --color-bg: #f8fafc;
            --color-surface: #ffffff;
            --color-text: #0f172a;
            --color-text-secondary: #475569;
            --color-border: #e2e8f0;
            --color-accent: #6366f1;
            --color-accent-hover: #4f46e5;
            --font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            --radius: 8px;
          }

          @media (prefers-color-scheme: dark) {
            :root {
              --color-bg: #0b0f19;
              --color-surface: #111827;
              --color-text: #f1f5f9;
              --color-text-secondary: #94a3b8;
              --color-border: #1e293b;
              --color-accent: #818cf8;
              --color-accent-hover: #a5b4fc;
            }
          }

          * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
          }

          body {
            background-color: var(--color-bg);
            color: var(--color-text);
            font-family: var(--font-family);
            font-size: 15px;
            line-height: 1.6;
            padding: 2.5rem 1rem;
          }

          .container {
            max-width: 960px;
            margin: 0 auto;
          }

          .header {
            background: var(--color-surface);
            border: 1px solid var(--color-border);
            border-radius: var(--radius);
            padding: 1.75rem 2rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
          }

          .header h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--color-text);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex-wrap: wrap;
          }

          .header p {
            color: var(--color-text-secondary);
            font-size: 0.95rem;
            line-height: 1.5;
          }

          .nav-links {
            margin-top: 1.25rem;
            display: flex;
            gap: 1rem;
          }

          .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.5rem 1.1rem;
            background: var(--color-accent);
            color: #ffffff !important;
            font-weight: 600;
            font-size: 0.875rem;
            border-radius: var(--radius);
            text-decoration: none;
            transition: background 0.2s ease;
          }

          .btn:hover {
            background: var(--color-accent-hover);
          }

          .badge {
            display: inline-block;
            background: var(--color-bg);
            border: 1px solid var(--color-border);
            color: var(--color-text-secondary);
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.2rem 0.65rem;
            border-radius: 9999px;
            margin-left: 0.5rem;
          }

          .table-wrap {
            background: var(--color-surface);
            border: 1px solid var(--color-border);
            border-radius: var(--radius);
            overflow-x: auto;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
          }

          table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.9rem;
          }

          th {
            background: var(--color-bg);
            color: var(--color-text-secondary);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            padding: 0.85rem 1.25rem;
            border-bottom: 1px solid var(--color-border);
          }

          td {
            padding: 0.85rem 1.25rem;
            border-bottom: 1px solid var(--color-border);
            color: var(--color-text);
          }

          tr:last-child td {
            border-bottom: none;
          }

          tr:hover td {
            background: rgba(99, 102, 241, 0.04);
          }

          a {
            color: var(--color-accent);
            text-decoration: none;
            word-break: break-all;
          }

          a:hover {
            text-decoration: underline;
          }

          .footer-note {
            text-align: center;
            margin-top: 2rem;
            font-size: 0.85rem;
            color: var(--color-text-secondary);
          }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>
              CE Notes — XML Sitemap
              <xsl:if test="sm:sitemapindex">
                <span class="badge">Sitemap Index</span>
              </xsl:if>
              <xsl:if test="sm:urlset">
                <span class="badge"><xsl:value-of select="count(sm:urlset/sm:url)" /> URLs</span>
              </xsl:if>
            </h1>
            <p>
              This XML Sitemap is indexed by search engines like Google and Bing to discover all articles and topics on CE Notes. With this stylesheet, it is displayed in human-readable format.
            </p>
            <div class="nav-links">
              <a href="/ce-notes/" class="btn">← Back to CE Notes Home</a>
            </div>
          </div>

          <div class="table-wrap">
            <!-- If this is a sitemapindex -->
            <xsl:if test="sm:sitemapindex">
              <table>
                <thead>
                  <tr>
                    <th style="width: 60px;">#</th>
                    <th>Sitemap Document</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="sm:sitemapindex/sm:sitemap">
                    <tr>
                      <td><xsl:value-of select="position()" /></td>
                      <td>
                        <a href="{sm:loc}"><xsl:value-of select="sm:loc" /></a>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </xsl:if>

            <!-- If this is a urlset -->
            <xsl:if test="sm:urlset">
              <table>
                <thead>
                  <tr>
                    <th style="width: 50px;">#</th>
                    <th>Page URL</th>
                    <xsl:if test="sm:urlset/sm:url/sm:lastmod">
                      <th style="width: 180px;">Last Modified</th>
                    </xsl:if>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="sm:urlset/sm:url">
                    <tr>
                      <td><xsl:value-of select="position()" /></td>
                      <td>
                        <a href="{sm:loc}"><xsl:value-of select="sm:loc" /></a>
                      </td>
                      <xsl:if test="sm:lastmod">
                        <td style="color: var(--color-text-secondary); font-size: 0.85rem;">
                          <xsl:value-of select="substring(sm:lastmod, 1, 10)" />
                        </td>
                      </xsl:if>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </xsl:if>
          </div>

          <p class="footer-note">
            Generated by Astro for CE Notes · Standard XML protocol: sitemaps.org
          </p>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
