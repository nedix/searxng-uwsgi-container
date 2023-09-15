const { addMatchImageSnapshotCommand } = require('@simonsmith/cypress-image-snapshot/command');

addMatchImageSnapshotCommand({
  customSnapshotsDir: 'snapshots',
});
