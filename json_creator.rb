require 'rubyXL'

def open_workbook(sheet)
  workbook = RubyXL::Parser.parse("posting-docs.xlsx")
  fields = workbook[sheet]
end

def create_file
  File.delete('fields.json')
  File.new('fields.json', 'w')
end

def create_FormFields
  form_fields = []

  fields = open_workbook('Fields')
  fields_sheet = fields.extract_data

  field_titles = fields_sheet[0]
  field_values = fields_sheet[1..-1]


  field_values.map do |value|
    new_field = Hash[field_titles.zip(value)]
    
    form_fields << new_field

    if new_field['InputType'] == "Dropdown"
      input_name = new_field['InputName']
      create_DropDownOptions(input_name)
    end
  end
end


def create_DropDownOptions(input_name)
  dropdown_sheet = open_workbook("#{input_name}Options")
  dropdown_data = dropdown_sheet.extract_data
end

create_file
create_FormFields