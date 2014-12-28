# coding: utf-8

require 'test_helper'
require 'tureng'

class TestTranslator < MiniTest::Unit::TestCase
	def test_should_output_translation_of_ruby
		translator = Tureng::Translator.new('Ruby')
		assert_output(/yakut/) { translator.draw_table } 
	end

	def test_should_output_translation_of_yakut
		translator = Tureng::Translator.new('Yakut')
		assert_output(/ruby/) { translator.draw_table } 
	end

	def test_should_output_translation_of_uzum
		translator = Tureng::Translator.new('Üzüm')
		assert_output(/grape/) { translator.draw_table } 
	end

	def test_when_should_output_term_not_found
		translator = Tureng::Translator.new('ihavenoideawhatiamwriting')
		assert_output(/Term not found/) { translator.draw_table }
	end

	def test_empty_table
		translator = Tureng::Translator.new('ruby')
		translator.draw_table
		refute translator.turkish_table.rows.empty?
		assert translator.english_table.rows.empty?
	end

	def test_should_not_print_empty_table
		translator = Tureng::Translator.new('ruby')
		assert_output(/^(?!English Terms).*/) { translator.draw_table }
		assert_output(/Turkish Terms/) { translator.draw_table }
		
		translator2 = Tureng::Translator.new('yakut')
		assert_output(/English Terms/) { translator2.draw_table }
		assert_output(/Turkish Terms/) { translator2.draw_table }

		translator3 = Tureng::Translator.new('halı')
		assert_output(/English Terms/) { translator3.draw_table }
		assert_output(/^(?!English Terms).*/) { translator3.draw_table }
	end
end
