require 'mechanize'

module Barcade
	class Scraper
		BASE_URI = 'http://barcadebrooklyn.com/'

		attr_accessor :date_slug

		def initialize(date_slug = Time.new.strftime('%Y/%m/%d/'))
			@date_slug = date_slug
		end

		def tap
			body = blog_post.search('section.entry > p').text
			body.split(/\n/)
		end

		def blog_post
			agent = Mechanize.new

			begin
				post = agent.get("#{BASE_URI}#{self.date_slug}")
			rescue Exception => e
			end
		end
	end
end