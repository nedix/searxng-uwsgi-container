const { addMatchImageSnapshotCommand } = require('@simonsmith/cypress-image-snapshot/command');
const installLogsCollector = require('cypress-terminal-report/src/installLogsCollector');

addMatchImageSnapshotCommand({
  comparisonMethod: 'ssim',
  customDiffDir: Cypress.spec.relative.replace(/^integration\/.*/, 'artifacts/snapshots/'),
  customSnapshotsDir: 'snapshots',
  e2eSpecDir: 'integration',
  failureThreshold: 0.2,
  failureThresholdType: 'percent',
});

installLogsCollector();
