# W8D2 - Lecture

- Integration Testing (Feature)

## Different Tests

- Unit tests test the Models, which interact with the database.

- Controller tests test the Controllers, which communicate info between the models and views. A controller accepts input and sends commands.

- Integration tests test the Views in the browser as well as the user experience. In other words, what’s being presented as HTML to users of the app.

## Integration Tests (Feature)

- A lot more high-level than unit tests, which focus on the technical details and business logic of your models.

- Describe flows on and between your pages.

- Feature tests which are based on your user stories, check if the requirements are being met or not

### Pros and Cons

- Tests that are not possible with other kind of tests

- Slower to run than unit tests

- Increases the costs of running tests

### Capybara

Capybara is a testing tool that allows us to:

- Automate Tests for the UI

- Writing assertions againts actual pages

- Written from the perspective of a user

- Simulate your browsers clicking through different actions such as clicking around and filling out forms

#### Setup

Gems we need:

- Capybara
- Selenium
- DatabaseCleaner

- [setup for Capybara](./setup.md)

## References

- [Capybara](https://github.com/teamcapybara/capybara)
- [Cabybara Ruby Doc](https://www.rubydoc.info/github/jnicklas/capybara)
