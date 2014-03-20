require 'mechanize'

module Barcade
	class Scraper
		BASE_URI = 'http://barcadebrooklyn.com/'

		attr_accessor :date_slug

		def initialize(date)
			@date_slug = date.strftime('%Y/%m/%d/')
		end

		def tap
			body = blog_post.search('section.entry > p').text
			body.split(/\n/)
		end

		def blog_post
			agent = Mechanize.new

			begin
				post = agent.get("#{BASE_URI}#{self.date_slug}")
			rescue Mechanize::ResponseCodeError => e
				puts e.response_code
			end
		end
	end
end
