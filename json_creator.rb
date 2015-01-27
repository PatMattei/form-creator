require 'rubyXL'

workbook = RubyXL::Parser.parse("posting-docs.xlsx")

def create_file
  File.delete('fields.json')
  File.new('fields.json', 'w')
end

def create_FormFields(workbook)
  form_fields = []


  fields = workbook['Fields']
  fields_sheet = fields.extract_data

  field_titles = fields_sheet[0]
  field_values = fields_sheet[1..-1]


  field_values.map do |value|
    form_fields << Hash[field_titles.zip(value)]
  end
  puts "#{form_fields}"
end




create_file
create_FormFields(workbook)