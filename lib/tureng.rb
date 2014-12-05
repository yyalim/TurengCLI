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

  class Translator
    attr_reader :word, :limit, :language_code, :table_type, :table, :status,
      :table_tag, :response, :uri

    def initialize(word, settings = {})
      @word = word
      @limit = settings[:limit]
      @language_code = settings[:language_code] || :en
      @table_type = settings[:table_type] || ''
      @table = Text::Table.new(
        horizontal_padding: 1,
        vertical_boundary: '=',
        horizontal_boundary: '|',
        boundary_intersection: 'O'
      )
      @uri = URI.escape(SEARCH_URL + word)
      @table_id = set_table_id
      @response = get_response
      @status = @response.css('h1')[1].text.strip
      @table_tag = parse_table_from_response
    end

    def set_table_id
      # sets table id by word language and 
      language = { en: 'english', tr: 'turkish' }
      "#{language[language_code]}#{table_type.capitalize}ResultsTable"
    end

    def get_response

      Nokogiri::HTML(open(uri), nil, 'utf-8')
    end

    def parse_table_from_response
      response.css("table[id='#{@table_id}']")
    end

    def fill_table
      # parse tr tags
      tr_tags = table_tag.css('tr')

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
      table.head = ['Suggestions']
      table.rows = @response.css('li a').map(&:text)
    end

    def draw_table
      if status == "Did you mean that?"
        puts status
        get_suggestions
      elsif status == "Term not found"
        puts status
        return nil
      else
        fill_table
      end

      puts table.to_s
    end
  end
end
