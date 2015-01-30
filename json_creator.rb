require 'rubyXL'
require 'json'

def create_file
  File.delete('fields.json')
  File.new('fields.json', 'w')
end

def open_workbook(sheet)
  workbook = RubyXL::Parser.parse("posting-docs.xlsx")
  workbook[sheet]
end



def create_FormFields
  form_fields = []

  fields_data = open_workbook('Fields')
  fields_sheet = fields_data.extract_data

  field_titles = fields_sheet[0]
  field_values = fields_sheet[1..-1]


  field_values.map do |value|
    new_field = Hash[field_titles.zip(value)]

    if new_field['InputType'] == "Dropdown"
      input_name = new_field['InputName']
      new_field["DropDownOptions"] = create_DropDownOptions(input_name)
    end
    form_fields << new_field
  end
  puts form_fields
  form_fields
end



def create_DropDownOptions(input_name)
  dropdown = {}
  dropdown_sheet = open_workbook("#{input_name}Options")
  dropdown_data = dropdown_sheet.extract_data

  dropdown_values = dropdown_data[1..-1]

  dropdown_values.map do |value|
    dropdown[value[0]] = value[1] 
  end
  dropdown
end

def create_SchoolName
end


def create_Copy
  copy = {}

  worksheet = open_workbook("Copy")
  copy_sheet = worksheet.get_table([]) 

  copy["CopyText"] = copy_sheet["CopyText"][0]
  copy["DisclaimerText"] = copy_sheet["DisclaimerText"][0]
  copy["AdditonalText"] = copy_sheet["AdditionalText"][0]
  copy
end


def write_to_json(form_fields, copy)  
  array = [{"Copy"=>copy, "FormFields"=>form_fields}]
  
  File.open('fields.json', 'a+') {|f| f.write(JSON.pretty_generate(array))}
end



create_file
school_name = create_SchoolName
form_fields = create_FormFields
copy = create_Copy
write_to_json(form_fields, copy)