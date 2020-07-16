require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_deputies_infos
  page = Nokogiri::HTML(URI.open("https://www.nosdeputes.fr/deputes"))

  deputes = Array.new(0)

  page.css('//tr/td/a').each.with_index do |link, index|
      complete_url = "https://www.nosdeputes.fr/deputes#{link["href"].to_s}"
      depute = Nokogiri::HTML(URI.open(complete_url))

      begin
        full_name = depute.css('.info_depute h1').text.to_s.split(" ")
        first_name = full_name[0].to_s
        last_name = full_name[1].to_s
      rescue => e
        first_name = "Prénom inconnu"
        last_name = "Nom inconnu"
      end

      begin
        email = depute.css("a[href^=mailto]").text.to_s
      rescue => e
        email = "Email inconnu"
      end

      deputes[index] = {
        "first_name" => first_name,
        "last_name" => last_name,
        "email" => email
      }

      puts "Le député #{last_name} #{first_name} peut être contacté à l'email suivant: #{email}"
    end


  return deputes
end

get_the_deputies_infos()