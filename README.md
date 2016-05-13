# Telegram Bot Heroku Guide

## Introduction
- Public Sample Guide : https://core.telegram.org/bots/samples

## Make Heroku App Spec
### 1. Ruby Rack App
- TGBotHello-rb

```sh
# Procfile
web: bundle exec puma -C config/puma.rb
```

```sh
# config/puma.rb
workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do

end
```

```ruby
# config.ru
require './app'
run Sinatra::Application # For example Sinatra
```

## Deploy app to Heroku
Create Heroku App

```sh
$ heroku apps:create [app-name]
```
Add remote heroku git repo

```sh
$ git remote add heroku [heroku-git-repo]
```

and deploy it

```sh
$ git push origin master
```
