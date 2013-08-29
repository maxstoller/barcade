require 'barcade/version'
require 'barcade/scraper'
require 'barcade/beeradvocate'

require 'terminal-table'

module Barcade
  class CLI
  	def self.start(*args)
  		barcade_scraper = Barcade::Scraper.new('2013/08/27/')
  		beeradvocate_scraper = BeerAdvocate::Scraper.new

  		beers = barcade_scraper.tap.map do |beer_name|
  			beeradvocate_profile = beeradvocate_scraper.find_beer_by_name(beer_name)
  			[beer_name, beeradvocate_profile[:score]] unless beeradvocate_profile.nil?
  		end.reject(&:nil?)

  		puts Terminal::Table.new rows: beers.sort
  	end
  end
end
