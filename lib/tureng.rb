# Authors: 
#  Mustafa Serhat DÜNDAR <msdundars@gmail.com>
#  Yusuf YALIM <yusufyalim@gmail.com>

require 'tureng/version.rb'
require 'nokogiri'
require 'open-uri'
require 'text-table'

module Tureng
  BASE_URL = 'http://tureng.com/'
  SEARCH_URL = BASE_URL + 'search/' 
  TABLE_SETTINGS = {        
    horizontal_padding: 1,
    vertical_boundary: '=',
    horizontal_boundary: '|',
    boundary_intersection: 'O'
  }

  class Translator
    attr_reader :word, :limit, :table_type, :english_table, :turkish_table, 
      :suggestions_table, :status, :table_tag, :response, :uri

    def initialize(word, settings = {})
      @word = word
      @limit = settings[:limit]
      @table_type = settings[:table_type] || ''
      @english_table = Text::Table.new(TABLE_SETTINGS)
      @turkish_table = Text::Table.new(TABLE_SETTINGS)
      @suggestions_table = Text::Table.new(TABLE_SETTINGS)
      @uri = URI.escape(SEARCH_URL + word)
      @response = get_response
      @status = @response.css('h1')[1].text.strip
    end

    def get_response
      Nokogiri::HTML(open(uri), nil, 'utf-8')
    end

    def parse_table_from_response(lang_code)
      lang = { en: 'english', tr: 'turkish' }
      table_id = "#{lang[lang_code]}#{table_type.capitalize}ResultsTable"
      response.css("table[id='#{table_id}']")
    end

    def fill_table(table)
      # parse tr tags
      tr_tags = table_tag.css('tr')

      return false if tr_tags.empty?

      # remove heading from tr_tags and save it to another variable
      headings = tr_tags.shift.css('th').map(&:text)

      # add headings to table as "##, Category, word language, translation
      # language".
      table.head = headings.values_at(1, 3, 4).unshift('##')

      # add translation to table
      tr_tags.each_with_index do |row, index|
        # add line number, category, word and translation to table
        table.rows << row.css('td').map(&:text).values_at(0, 1, 3, 4)
        # end loop if limit is set and index greater than or equal to limit
        break if limit && index >= (limit - 1)
      end
    end

    def get_suggestions
      suggestions_table.head = ['Suggestions']
      suggestions_table.rows = @response.css('li a').map(&:text)
    end

    def draw_table
      if status == "Did you mean that?"
        puts status
        get_suggestions
        puts @suggestions_table.to_s
        return false
      elsif status == "Term not found"
        puts status
        return false
      else
        @table_tag = parse_table_from_response(:en)
        fill_table(@english_table)
        
        @table_tag = parse_table_from_response(:tr)
        fill_table(@turkish_table)
      end

      puts "Turkish Terms"
      puts @english_table.to_s
      
      puts "English Terms"
      puts @turkish_table.to_s
    end
  end
end
