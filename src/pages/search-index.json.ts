import { getCollection } from 'astro:content';

export async function GET() {
  const posts = await getCollection('blog', ({ data }) => !data.draft);
  const index = posts.map((post) => ({
    title: post.data.title,
    description: post.data.description,
    url: `/posts/${post.data.slug ?? post.slug}/`,
    tags: post.data.tags,
  }));

  return new Response(JSON.stringify(index), {
    headers: { 'Content-Type': 'application/json' },
  });
}
