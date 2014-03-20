require 'barcade/version'
require 'barcade/scraper'
require 'barcade/beeradvocate'

require 'terminal-table'

module Barcade
  class CLI
  	def self.start(*args)
      date_slug = case args[0]
      when '--yesterday'
        Date.today.prev_day.strftime('%Y/%m/%d/')
      else
        Date.today.strftime('%Y/%m/%d/')
      end

  		barcade_scraper = Barcade::Scraper.new(date_slug)
  		beeradvocate_scraper = BeerAdvocate::Scraper.new

  		beers = barcade_scraper.tap.map do |beer_name|
  			beeradvocate_profile = beeradvocate_scraper.find_beer_by_name(beer_name)
  			[beer_name, beeradvocate_profile[:score]] unless beeradvocate_profile.nil?
  		end.compact

  		puts Terminal::Table.new rows: beers.sort
  	end
  end
end
