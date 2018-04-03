# JungleScout Amazon Scraper

Hello! It's important we cover a couple things before diving it:

I had two choices when it came to getting Amazon product information:
* scrape it
* amazon advertising api

Given the requirements to becoming an Amazon associate, I decided to implement this problem as a scraper. Therefore, the requirements were implemented dealing with the `B002QYW8LW` amazon product from a scraping perspective.

## Overview

This is a rails backend that scrapes amazon product and product review pages. If the requested product or page of reviews has already been scraped, it is returned from the database. If not, the product or product reviews are scraped, and then saved.

## System Dependencies
* npm
* yarn

## Test Suite (Rails)
* `bundle exec rspec` will run all the tests

*Testing Note*
I haven't added any tests that cover the serializers, as I think I would be testing AMS, and not any new functionality introduced by the serializers, as they're pretty simple.

Additionally, the controller tests simply assert that the routes return successfully and increase database object counts. The tests covering the services assert that the right information is returned.

## Starting Up
* `gem install bundler`
* `bundle install`
* `./bin/webpack-dev-server` (for webpack)
* `rails server` (for rails)

## Services
I delegated the actual product / review lookup to a couple service. Each lookup service does the same thing:
  * finds the product or reviews by ASIN in the db, if they exist
  * delegate to scraping service to pull in product / review info, if they do not exist
  * returns the product / reviews

## React Usage
Okay, so this is my first time making something with React. I approached things from a "make it work" perspective, and as a result avoided extra libraries if I could (I'm looking at you, Flux!).

## Potential Refactoring
* actually pull in Flux
* make each react peice its own component
* implement Stores
* show a list of all products stored in db on load (not in requirements, but I think it would be a good idea)
