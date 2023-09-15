it('It should render the index page.', () => {
  cy.visit('/');
  cy.get('main').matchImageSnapshot('index-page');
});
