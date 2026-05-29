const { defineConfig, devices } = require("@playwright/test");

module.exports = defineConfig({
  testDir: "./specs",
  fullyParallel: false,
  workers: 1,
  retries: 0,
  timeout: 60_000,
  expect: {
    timeout: 15_000,
  },
  reporter: process.env.CI
    ? [["list"], ["html", { open: "never", outputFolder: "playwright-report" }]]
    : [["list"]],
  use: {
    baseURL: "http://localhost:4000",
    trace: "retain-on-failure",
    screenshot: "only-on-failure",
    headless: !process.env.SLOW,
  },
  // reuseExistingServer: true — reuses your running dev server during normal
  // development (fast). Starts a fresh one automatically when not running,
  // so `mix storybook` is always callable without a pre-started server.
  webServer: {
    command: "sh -c 'cd ../.. && mix phx.server'",
    url: "http://localhost:4000/storybook",
    reuseExistingServer: true,
    timeout: 180_000,
    stdout: "pipe",
    stderr: "pipe",
  },
  projects: [
    {
      name: "chromium",
      use: { ...devices["Desktop Chrome"] },
    },
  ],
});
