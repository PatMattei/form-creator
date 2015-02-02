require 'json'
require 'rubygems'

def open_file
  json_file = File.read('fields.json')
  parsed_file = JSON.parse(json_file)
end

def create_validate_form(data)
  form = data[0]['FormFields']

  File.open('new/form_validation.js', 'a+') {|f| f.write("function validate_form()\n")}
  File.open('new/form_validation.js', 'a+') {|f| f.write("{\n")}

  index = 0

  form.to_a.each_with_index do |content|
    required = content['Required']
    input_type = content['InputType']
    input_id = content['InputID']
    display_name = content['DisplayName']

    if required == true && input_type != "Hidden" 
      if index != 0
        File.open('new/form_validation.js', 'a+') {|f| f.write("\n\telse")}
      end
      
      if input_type == "Checkbox"
        File.open('new/form_validation.js', 'a+') {|f| f.write("\tif(document.getElementById('#{input_id}').checked == false)")}
      else
        File.open('new/form_validation.js', 'a+') {|f| f.write("\tif (document.getElementById('#{input_id}').value=='')")}
      end      

      display_name = display_name.gsub("\n", "")

      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t{")}
      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t\talert(\"Required Field: #{display_name}\");")}
      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t\tdocument.getElementById('#{input_id}').focus();")}
      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t\treturn false;")}
      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t}\n")}

      index += 1
    end
  end
  File.open('new/form_validation.js', 'a+') {|f| f.write("\n\treturn true;")}
  File.open('new/form_validation.js', 'a+') {|f| f.write("\n}")}
end  

data = open_file
create_validate_form(data)