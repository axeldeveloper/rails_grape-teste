# Project Rails Grape Api

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

#Project Using

* Grape
* Grape-swagger
* Rails
* 


# Run 
rails s -p 5000

http://host:port/api/swagger
rails generate swagger:layout


```
class YourAPI < Grape::API
  version 'v1'
  format :json
  ...
  add_swagger_documentation :add_version => true,
                            :base_path => '/api'
end

```
rails g serializer user

http://apionrails.icalialabs.com/book/chapter_seven