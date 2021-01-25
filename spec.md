# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app

The way I use Sinatra is by ensuring the Sinatra gem is included in my Gemfile and making sure my main application controller inherits from Sinatra::Base. Also, I ensure my each of my application controllers is mounted properly in the config.ru file.

- [x] Use ActiveRecord for storing information in a database

When building my model classes I use the 'activerecord' gem and ensure my classes inherit from ActiveRecord::Base.

- [x] Include more than one model class (e.g. User, Post, Category)

My application has 3 main models; User, Item and Pack.

- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)

User models have two has_many relationships; a has_many Packs and a has_many Items. Packs have one has_many relationship and one belongs_to relationship; a has_many items and a belongs_to User.

- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)

Items have two belongs-to relationships; a belongs_to User and a belongs_to Pack.

- [x] Include user accounts with unique login attribute (username or email)

I validated the uniqueness of username by using an active record validation method in my user model class. The validation ensures a duplicate username can't be saved to the database. I wrote a conditional into my User controller that checks to see if the validation prevents the user from being saved. If it does, the user is redirected back to login with an error message. If the validation does not prevent the user from being saved the user instance is created.

- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying

Two application resources belong to the User; Items and Packs. Users can create, read, update and destroy Items and Packs.

- [x] Ensure that users can't modify content created by other users

Edit and Delete routes have user conditions that ensure only Users can edit, and delete resources they own.

- [x] Include user input validations

I Validate user input by writing conditionals to ensure input fields are not empty.

- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)

I used the sinatra flash gem to create and display error messages when a prohibited action is attempted.

- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

I added the description, install instructions, and a link to the license but not sure about a contributors guide.

Confirm
# I declare I should have made more and smaller commits and narrowed the scope of each commit to meet these requirements. Wasn't sure I could correct without starting the project over. Should I go and edit commits?
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
