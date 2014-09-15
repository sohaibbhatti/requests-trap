# [Requests Trap](http://sb-requests-trap.herokuapp.com/)

Requests Trap captures and displays HTTP requests. Requests(GET/POST/PUT
etc) sent to a particular URL are stored internally into the Database.
They can later be viewed.

Requests can be viewed in real-time. E.g. if requests are being sent to
/foo, viewing the /foo/requets URL will show the new requests in real
time. This is achieved via Rails 4 ActionController::Live streaming and
PostgreSQL NOTIFY/LISTEN.

A live demo of Requests Trap can be viewed
[here](http://sb-requests-trap.herokuapp.com/)


## Routes
  The app has four routes:

| Route                  | Description                           |
|------------------------|---------------------------------------|
| /                      | Splash Page with some instructions    |
| /:trap_id              | Requests to be captured are sent here |
| /:trap_id/requests     | Display/view live stream of requests  |
| /:trap_id/requests/:id | View a single request                 |

## Setting up

1. Clone the repository
2. bundle install
3. Remove the .example suffix from config/database.yml.example and enter
   relevant credentials
4. You're done!


NOTE: To view live streaming in development environment,
```config.cache_classes``` and ```config.eager_load``` need to be set to
true in config/environments/development.rb

## Issues that need to be looked into

Testing out live Streaming functionality proved to be really difficult.
Need to read up on good ways of testing such functionality.


