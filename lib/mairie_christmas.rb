require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_town_halls_emails
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

  townhalls = Array.new(0)

  page.css('//a[@class=lientxt]/@href').each.with_index do |href, index|
    complete_url = "http://annuaire-des-mairies.com/#{href}"
    townhall = Nokogiri::HTML(URI.open(complete_url))
    
    city = townhall.css("h1")[1].text.split(" - ")[0].to_s
    
    begin
    email = townhall.css("tr.txt-primary")[3].css("td")[1].text.to_s
    rescue  => e
    email = "Inconnu" 
    end
    
    townhalls[index] = { city => email }
    
    puts "Mairie de #{city} - Email: #{email}"

  end

  return townhalls
end

get_town_halls_emails()