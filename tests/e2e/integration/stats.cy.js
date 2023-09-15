it('It should render the stats page.', () => {
  cy.visit('/stats');
  cy.get('main').matchImageSnapshot('stats-page');
})
