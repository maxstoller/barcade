require 'barcade/version'
require 'barcade/scraper'
require 'barcade/beeradvocate'

require 'terminal-table'

module Barcade
  class CLI
  	def self.start(*args)
      date = case args[0]
      when '--yesterday'
        Date.today.prev_day
      else
        Date.today
      end

  		barcade_scraper = Barcade::Scraper.new(date)
  		beeradvocate_scraper = BeerAdvocate::Scraper.new

  		beers = barcade_scraper.tap.map do |beer_name|
  			beeradvocate_profile = beeradvocate_scraper.find_beer_by_name(beer_name)
  			[beer_name, beeradvocate_profile[:score]] unless beeradvocate_profile.nil?
  		end.compact

      print_table(beers, date)
  	end

    def self.print_table(beers, date)
      beers.sort! { |a, b| b[1] <=> a[1] }

      table = Terminal::Table.new(rows: beers)
      table.title = "#{date.strftime('%A')}'s Tap"
      table.headings = ['Name', 'BeerAdvocate Score']
      table.align_column(1, :center)

      puts table
    end
  end
end
