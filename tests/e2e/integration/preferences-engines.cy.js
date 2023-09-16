const engines = require('../fixtures/engines.json');

beforeEach(() => {
  cy.visit('/preferences');
  cy.get('#tab-label-engines').click();
});

Object.keys(engines).forEach((tab) => {
  it(`Should render the '${tab}' engines.`, () => {
    cy.get('#tab-content-engines').contains('label[role="tab"]', tab).click();

    cy.get(`#tab-content-category_${tab} table.table_engines > tbody > tr:has(th.name):not(:first-child)`).each(($tr) => {
      cy.wrap($tr).within(() => {
        cy.get('th.name').invoke('data', 'engine-name').then((engine) => {
          console.log(tab, engines[tab], engine, engines[tab].includes(engine));

          if (engines[tab].includes(engine)) {
            cy.get('input.reversed-checkbox').should('not.be.checked');
          } else {
            cy.get('input.reversed-checkbox').should('be.checked');
          }
        });
      });
    });
  });
});
