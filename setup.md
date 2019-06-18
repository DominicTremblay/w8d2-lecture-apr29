<!-- #### START HERE FOR DEMO -->

12.Setup for Capybara

12.1. Add the gems in the test group

```ruby
  gem 'capybara-selenium'
  gem 'webdrivers', '~> 3.0'
  gem 'database_cleaner'
```

12.2. Add to rails_helper

```ruby
require "selenium/webdriver"
require 'webdrivers'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome
```

12.3.Set transactional fixtures to false

13.Setup Factory Bot

13.1.Add gem

```ruby
group :development, :test do
  gem 'factory_bot_rails'
end
```

13.2.Add to rails_helper

`config.include FactoryBot::Syntax::Methods`

14.Create the controller and the view for cars

`rails g controller cars index`

14.1.Add the @products instance in controller

`@cars = Car.all`

14.2.Add routing

`resources :cars, only: [:index]`

14.2.Add the view code

14.2.1.Create and run the seed file

14.3.Add description method in car model

```ruby
  def description
    "#{make.make} #{model.model} #{style.body_style} #{trim.trim_level} #{year}".gsub('  ', ' ')
  end
```

14.4.Add CSS

15.Feature Specs

15.1.Generate feature spec cars

- rails g rspec:feature cars
- `rspec spec/features`

  15.2.Add js:true

`RSpec.feature "Cars", type: :feature, js: true do`

15.3.Create the scenario

```ruby
  scenario "display the cars page" do

    visit cars_path

    save_screenshot('cars_page.png')
    expect(page).to have_text('All My Cars!')

  end
```

15.3.1.Add a car

```ruby

  before :each do
    @car1 = Car.create!(
      make: Make.create!(make: 'Lincoln'),
      model: Model.create!(model: 'M3'),
      trim: Trim.create(trim_level: 'XLE'),
      style: Style.create!(body_style: 'Extended Cab Pickup'),
      year: 1971,
      colour: 'Ruby Red'
    )

    @car2 = Car.create!(
      make: Make.create!(make: 'Buick'),
      model: Model.create!(model: 'Mustang'),
      trim: Trim.create(trim_level: 'XLE'),
      style: Style.create!(body_style: 'Passenger Van'),
      year: 1971,
      colour: 'Royal Blue'
    )
  end
```

15.4.Config for Database Cleaner

15.4.1 Create the spec/support folder and within it create a file called database_cleaner.rb.

15.4.2 Paste the following code

```ruby
RSpec.configure do |config|

config.before(:suite) do
  if config.use_transactional_fixtures?
    raise(<<-MSG)
      Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
      (or set it to false) to prevent uncommitted transactions being used in
      JavaScript-dependent specs.

      During testing, the app-under-test that the browser driver connects to
      uses a different database connection to the database connection used by
      the spec. The app's database connection would not be able to access
      uncommitted transaction data setup over the spec's database connection.
    MSG
  end
  DatabaseCleaner.clean_with(:truncation)
end

config.before(:each) do
  DatabaseCleaner.strategy = :transaction
end

config.before(:each, type: :feature) do
  # :rack_test driver's Rack app under test shares database connection
  # with the specs, so continue to use transaction strategy for speed.
  driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

  if !driver_shares_db_connection_with_specs
    # Driver is probably for an external browser with an app
    # under test that does *not* share a database connection with the
    # specs, so use truncation strategy.
    DatabaseCleaner.strategy = :truncation
  end
end

config.before(:each) do
  DatabaseCleaner.start
end

config.append_after(:each) do
  DatabaseCleaner.clean
end

end
```

15.4.3.Add require for database cleaner in our feature test

`require 'support/database_cleaner'`

15.5.Modify the Scenario

```ruby
  scenario "display the list of cars" do

    visit cars_path

    expect(page).to have_css('.car', count: 2)
    expect(page).to have_text('Lincoln M3 Extended Cab Pickup XLE 1971')
    expect(page).to have_text('Buick Mustang Passenger Van XLE 1971')
    save_screenshot('all_cars.png')

  end
```

15.6.Add Another Scenario for filtering

```ruby

  scenario "filter according to the make" do

    visit cars_path

    within 'form' do
      select 'Buick', from: 'make'
      click_button 'Search!'
    end

    expect(page).to have_css('.car', count: 1)
    expect(page).to have_text('Buick Mustang Passenger Van XLE 1971')

    save_screenshot 'filter_make.png'
  end
```

15.7.Modify the Products Controller

`@cars = Car.where(make: params[:make]) if params[:make].present`
