# coding: utf-8
#require 'tureng/version.rb'

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file

# Mustafa Serhat DÜNDAR
# msdundars@gmail.com

require 'nokogiri'
require 'open-uri'
require 'text-table'

BASE_URL = 'http://tureng.com'
SEARCH_URL = BASE_URL + '/search/'

class Tureng
  def initialize(word)
    @word = word
  end

  def get_response
    uri = SEARCH_URL + @word
    @response = Nokogiri::HTML(open(uri), nil, 'utf-8')
  end

  def parse_tables_from_response
    @en_tr_table = @response.css("table[id='englishResultsTable']")
    @en_tr_table_full = @response.css("table[id='englishFullResultsTable']")
  end

  def draw_results(params)
    parse_tables_from_response

    params == "en_to_tr" ? (source = @en_tr_table) : (source = @en_tr_table_full)

    # draw an empty table
    table = Text::Table.new(
    	horizontal_padding: 1,
	    vertical_boundary: '=',
	    horizontal_boundary: '|',
      boundary_intersection: 'O'
    )

    # parse tr tags
    tr_tags = source.css('tr')

    # remove heading from tr_tags and save it to another variable
    headings = tr_tags.shift.css('th').map(&:text)


    # add headings to table
    table.head = headings.values_at(1, 3, 4).unshift('##')

    tr_tags.each do |row|
      table.rows << row.css('td').map(&:text).values_at(0, 1, 3, 4)
    end

    # draw table
    puts table.to_s
  end

  def get_suggestions
    # draws suggestions table
    table = Text::Table.new
    table.head = [' Öneriler ']

    table.rows = @response.css('li a').map(&:text)

    # draw table
    puts table.to_s
  end

  def draw_all_results
    get_response
    status = @response.css('h1')[1].text.strip

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
    #begin
      input = gets.chomp
      unless quit_values.include?(input)
        c = Tureng.new(input)
        c.draw_all_results
      else
        break
      end
    #rescue 
      puts "Hatalı giriş, tekrar deneyin!"
    #end
  end
end

translate
