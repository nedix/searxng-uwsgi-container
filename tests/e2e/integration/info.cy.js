beforeEach(() => {
  cy.visit('/');
  cy.contains('span', 'About').closest('a').click();
});

it('It should render the about page.', () => {
  cy.location('pathname').then(pathname => expect(pathname).to.satisfy(path => path.startsWith('/info/')));
  cy.get('main').matchImageSnapshot('about-page');
});

it('It should render the search syntax page.', () => {
  cy.contains('a', 'Search syntax').click();
  cy.location('pathname').then(pathname => expect(pathname).to.satisfy(path => path.startsWith('/info/')));
  cy.get('main').matchImageSnapshot('search-syntax-page');
});
