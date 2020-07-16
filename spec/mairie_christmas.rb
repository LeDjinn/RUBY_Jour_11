require_relative "../lib/mairie_christmas.rb"

describe "Vérifier le nombre de résultats" do
  it "au minimum 10" do
    expect((get_town_halls_emails).count).to be > 40
  end
end