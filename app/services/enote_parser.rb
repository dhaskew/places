
class ParsedEnote
  attr_reader :locations, :visits
  
  def initialize
    @locations = []
    @visits = []
  end

  def add name, link, address, durration
    next_item = { name: name, href: link, address: address, mins: durration }
    @visits << next_item
    @locations << next_item if @locations.map{ |visit| visit[:name] }.count(name) == 0
  end

end

class EnoteParser
  def self.parse xml_string
    enote = Nokogiri::XML(xml_string)
    pn = ParsedEnote.new
 
    visit_count = enote.css('table tr td').count / 3

    (1..visit_count).each do |i|
      node = enote.css('table tr td')[3*i]
      href = node.children[1].children[0].children[0].children[0].attributes["href"].value
      name = node.children[1].children[0].children[0].children[0].children[0].text
      address = node.children[3].children[0].children[0].children[0].text
      durration = text_to_minutes node.children[5].children[0].text
      pn.add name, href, address, durration
    end
    return pn
  end

  private
  
  def self.text_to_minutes durration
    words = durration.scan(/\w+/)
    if words.length == 2
      return words[0].to_i
    elsif words.length == 4
      return ((words[0].to_i * 60) + words[2].to_i)
    else
      return ((words[0].to_i * 24 * 60) + (words[2].to_i * 60) + words[4].to_i)
    end
  end

end
