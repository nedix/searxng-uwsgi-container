it('It should render the 404 page if a page could not be found.', () => {
  cy.visit('/404', {failOnStatusCode: false});
  cy.get('main').matchImageSnapshot('404-page');
});
