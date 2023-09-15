const { defineConfig } = require('cypress');
const { addMatchImageSnapshotPlugin } = require('@simonsmith/cypress-image-snapshot/plugin');

module.exports = defineConfig({
  e2e: {
    specPattern: 'integration/**/*.cy.{js,jsx,ts,tsx}',
    supportFile: 'cypress.support.js',
    setupNodeEvents(on) {
      addMatchImageSnapshotPlugin(on)
    },
  },
  screenshotOnRunFailure: true,
  video: false,
});
