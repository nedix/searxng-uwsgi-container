const { addMatchImageSnapshotCommand } = require('@simonsmith/cypress-image-snapshot/command');

addMatchImageSnapshotCommand({
  customDiffDir: Cypress.spec.relative.replace(/^integration\/.*/, 'artifacts/snapshots/'),
  customSnapshotsDir: 'snapshots',
  e2eSpecDir: 'integration',
  failureThreshold: 0.05,
  failureThresholdType: 'percent',
});
