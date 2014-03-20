require 'mechanize'

module BeerAdvocate
  class Scraper
    BASE_URI = 'http://beeradvocate.com/'

    def find_beer_by_name(name)
      agent = Mechanize.new

      agent.get(BASE_URI) do |page|
        search_results = page.form_with(class: 'formPopup') do |search|
          search.q = name
        end.submit

        profile_link = search_results.link_with(href: /profile/)

        if profile_link
          profile_page = profile_link.click

          if element = profile_page.search('.BAscore_big').first
            return { score: element.text }
          end
        end

        return nil
      end
    end
  end
end