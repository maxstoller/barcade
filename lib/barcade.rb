require 'barcade/version'
require 'barcade/scraper'

module Barcade
  class CLI
  	def self.start(*args)
  		barcade_scraper = Barcade::Scraper.new('2013/08/27/')
  		puts barcade_scraper.tap
  	end
  end
end
