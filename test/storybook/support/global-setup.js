const { request } = require("@playwright/test");
const fs = require("fs");
const path = require("path");

const OUTPUT_PATH = path.join(__dirname, "story-urls.json");
const BASE_URL = "http://localhost:4000";
// Storybook files live two directories up from this support/ folder
const STORYBOOK_DIR = path.join(__dirname, "..", "..", "..", "storybook");

// Derive the Storybook URL path from a .story.exs file path.
// e.g. storybook/components/forms/button.story.exs → /storybook/components/forms/button
function fileToUrl(filePath) {
  const rel = path.relative(STORYBOOK_DIR, filePath);
  const withoutExt = rel.replace(/\.story\.exs$/, "");
  return "/storybook/" + withoutExt.split(path.sep).join("/");
}

function discoverStoryFiles(dir) {
  const results = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      results.push(...discoverStoryFiles(full));
    } else if (entry.isFile() && entry.name.endsWith(".story.exs")) {
      results.push(full);
    }
  }
  return results;
}

module.exports = async () => {
  // globalSetup runs before webServer starts. Poll until the dev server is ready.
  const pollCtx = await request.newContext({ baseURL: BASE_URL });
  let serverReady = false;
  try {
    for (let i = 0; i < 45; i++) {
      try {
        const res = await pollCtx.get("/storybook");
        if (res.ok()) { serverReady = true; break; }
      } catch (_) {}
      if (i < 44) await new Promise((r) => setTimeout(r, 2_000));
    }
  } finally {
    await pollCtx.dispose();
  }
  if (!serverReady) {
    throw new Error(`Dev server at ${BASE_URL}/storybook did not become ready in 90s.`);
  }

  // Discover stories from the filesystem — sidebar-based discovery misses
  // stories in collapsed folders that are not rendered in the DOM.
  const storyFiles = discoverStoryFiles(STORYBOOK_DIR);
  const urls = storyFiles.map(fileToUrl).sort();

  if (urls.length === 0) {
    throw new Error(
      `No .story.exs files found under ${STORYBOOK_DIR}. Check the path.`
    );
  }

  fs.writeFileSync(OUTPUT_PATH, JSON.stringify(urls, null, 2));
  console.log(`[storybook smoke] Discovered ${urls.length} stories → ${OUTPUT_PATH}`);
};
