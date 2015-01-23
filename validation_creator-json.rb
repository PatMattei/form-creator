require 'json'
require 'rubygems'

def open_file
  json_file = File.read('fields.json')
  parsed_file = JSON.parse(json_file)
end



def create_validate_form(data)
  form = data['FormFields']

  File.open('new/form_validation.js', 'a+') {|f| f.write("function validate_form()\n")}
  File.open('new/form_validation.js', 'a+') {|f| f.write("{\n")}

  form.each_with_index do |content, index|
    required = content['Required']
    input_type = content['InputType']
    input_id = content['InputID']
    display_name = content['DisplayName']

    if required == true && index != 0 && input_type != "Hidden"
      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\telse")}
    
      if input_type == "Checkbox"
        File.open('new/form_validation.js', 'a+') {|f| f.write("\tif(document.getElementById('#{input_id}').checked == false)")}
      else
        File.open('new/form_validation.js', 'a+') {|f| f.write("\tif (document.getElementById('#{input_id}').value=='')")}
      end      

      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t{")}
      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t\talert(\"#{display_name} is a required field.\");")}
      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t\tdocument.getElementById('#{input_id}').focus();")}
      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t\treturn false;")}
      File.open('new/form_validation.js', 'a+') {|f| f.write("\n\t}\n")}
    end
  end
  File.open('new/form_validation.js', 'a+') {|f| f.write("\n\treturn true;")}
  File.open('new/form_validation.js', 'a+') {|f| f.write("\n}")}
end  

#create HTML page
data = open_file
create_validate_form(data)