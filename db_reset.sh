#!/bin/bash
# 2017-05-24 11:00:30 edition

export RAILS_ENV=development
bin/rails db:environment:set RAILS_ENV=development

bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:populate
bundle exec rake db:test:prepare
