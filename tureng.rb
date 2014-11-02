# coding: utf-8
# Mustafa Serhat DÜNDAR
# msdundars@gmail.com

require 'nokogiri'
require 'open-uri'
require 'text-table'

class Tureng
  def initialize(w, u = "http://tureng.com/search/")
    @word, @url = w, u
  end

  def get_response
    uri = @url + @word
    @response = Nokogiri::HTML(open("#{uri}"), nil, 'utf-8')
  end

  def parse_tables_from_response
    get_response
    @en_tr_table = @response.css("table[id='englishResultsTable']")
    @en_tr_table_full = @response.css("table[id='englishFullResultsTable']")
  end

  def draw_results(params)
    parse_tables_from_response

    params == "en_to_tr" ? (source = @en_tr_table) : (source = @en_tr_table_full)

    # draw an empty table
    table = Text::Table.new :horizontal_padding    => 1,
                :vertical_boundary     => '=',
                :horizontal_boundary   => '|',
                :boundary_intersection => 'O'

    # parse table headings
    headings = source.css('th')

    # add headings to table
    table.head = ["##","#{headings[1].text}", "#{headings[3].text}", "#{headings[4].text}"]
    
    # parse and count translation results
    tr_tags = source.css("tr")
    size_of_tr_tags = tr_tags.size - 1 # -1 is for th tags

    # fill table with results
    for i in 1..size_of_tr_tags
      translations = tr_tags[i].css("td")
      table.rows << [["#{translations[0].text}", "#{translations[1].text}", "#{translations[3].text}", "#{translations[4].text}"]]
    end

    # draw table
    puts table.to_s
  end

  def get_suggestions
    suggestion_size = @response.css("li a").size

    # draw suggestions table
    table = Text::Table.new
    table.head = [" Öneriler "]

    # fill table with suggestions
    for i in 1..(suggestion_size - 1)
      table.rows << @response.css("li a")[i].text
    end

    # draw table
    puts table.to_s
  end

  def draw_all_results
    get_response
    status = @response.css("h1")[1].text.strip

    if status == "Did you mean that?"
      puts "Aradığınız kelime bulunamadı. Bunlardan birini yazmak istemiş olabilir misiniz?"
      get_suggestions
    elsif status == "Term not found"
      puts "Aradığınız kelime bulunamadı."
    else
      draw_results("en_to_tr")
      draw_results("en_to_tr_full")
    end
  end
end

# Dead simple, quite basic interpretation
def translate
  quit_values = ["q", "quit", "exit"]
  while true
    puts "Tureng'de aramak istediğiniz kelimeyi girin: "
    begin
      input = gets.chomp
      unless quit_values.include?(input)
        c = Tureng.new("#{input}")
        c.draw_all_results
      else
        break
      end
    rescue
      puts "Hatalı giriş, tekrar deneyin!"
    end
  end
end

translate