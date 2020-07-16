require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_currencies
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

  cryptos = Array.new(0)

  

  page.css(".cmc-table-row").each.with_index do |line, index|
    
    crypto_name = line.css(".cmc-table__cell--sort-by__name").text
    crypto_price = line.css(".cmc-table__cell--sort-by__price").text.gsub("$", "").gsub(",", "").to_f

    cryptos[index] = { crypto_name => crypto_price }

    puts "Rang n°#{index+1} - #{crypto_name} : #{crypto_price} $"

  end

  return cryptos
  
end

get_currencies()



