require 'test_helper'
require 'tureng'
include Tureng

class TestTranslator < MiniTest::Unit::TestCase
	def setup
		settings = { language_code: :en }
		@translator = Translator.new('ruby', settings)
	end

	def test_should_output_translation_of_ruby  
		assert_output(/yakut/) { @translator.draw_table } 
	end
end
