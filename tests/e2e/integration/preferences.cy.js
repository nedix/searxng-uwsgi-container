beforeEach(() => {
  cy.visit('/preferences');
});

it('It should render the general tab.', () => {
  cy.get('main').matchImageSnapshot('general-tab');
});

it('It should render the user interface tab.', () => {
  cy.contains('label', 'User interface').click();
  cy.get('main').matchImageSnapshot('ui-tab');
});

it('It should render the privacy tab.', () => {
  cy.contains('label', 'Privacy').click();
  cy.get('main').matchImageSnapshot('privacy-tab');
});

it('It should render the special queries tab.', () => {
  cy.contains('label', 'Special Queries').click();
  cy.get('main').matchImageSnapshot('special-queries-tab');
});

it('It should save settings to cookies.', () => {
  cy.contains('label', 'Cookies').click();
  cy.get('input[type="submit"][value="Save"]').click();
  cy.visit('/preferences');
  cy.contains('label', 'Cookies').click();
  cy.get('table.cookies').matchImageSnapshot('cookies-tab-saved');
});
