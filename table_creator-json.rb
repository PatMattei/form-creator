require 'json'
require 'rubygems'

def open_file
  json_file = File.read('fields.json')
  parsed_file = JSON.parse(json_file)
end



def create_fields(data)
  field_on_line = 0
  line_number = 0

  form = data[0]['FormFields']

  form.to_a.each_with_index do |content, line_number|
    col_span = content['Colspan']
    display_name = content['DisplayName']
    input_type = content['InputType'] 
    input_id = content['InputID']
    input_name = content['InputName']
    max_length = content['MaxLength']
    value = content['Value']
    required = content['Required']
    
    if line_number > 0
      new_row_check(field_on_line)
    end

    field_on_line += col_span
    
    create_tabledef(col_span, display_name, field_on_line, input_type, input_id)

    if input_id == 'leadid_tcpa_disclosure' 
      create_disclosure(display_name)
    end

    required_check(required, input_type)

    if input_type == 'DropDown'
      create_dropdown(content['DropDownOptions'], input_name, input_id)
    else
      create_input(input_type, input_name, input_id, max_length, value)
    end
    
    if field_on_line > 1
      field_on_line = 0
    end

  end
end



def create_disclosure(display_name)
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t<label for='leadid_tcpa_disclosure'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t\t<span class='disclosure'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t\t\t#{display_name}")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t\t</span>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t</label>")}
end


def create_tabledef(colspan, display_name, field_on_line, input_type, input_id)
  if input_type == "Hidden" 
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t</tr>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t<tr>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t<td style='display:none'>")}
  elsif input_id == "leadid_tcpa_disclosure"
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t</tr>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t<tr>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t<td colspan = #{colspan}>")}
  elsif field_on_line > 2
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t</tr>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t<tr>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t<td colspan = #{colspan}>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t#{display_name}")}
  else
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t<td colspan = #{colspan}>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t#{display_name}")}
  end
end



def required_check(required, input_type)
  if required == true  && input_type != "Hidden"
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t<img border='0' src='images/req.gif' width='7' height='6'>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t<br>")}
  else
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t<br>")}
  end
end  

def create_input(input_type, input_name, input_id, max_length, value)
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t<input type='#{input_type}' name='#{input_name}' id='#{input_id}' maxlength='#{max_length}' value='#{value}'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t</td>")}
end


def new_row_check(field_on_line)
  if field_on_line != 1
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t</tr>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t<tr>")}
  end
end

def create_dropdown(options, input_name, input_id)
  dropdown_options = options
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t<select name='#{input_name}' id='#{input_id}'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t<option value=''>Select One</option>")}

  dropdown_options.each do |option| 
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t<option value='#{option[0]}'>#{option[1]}</option>")}
  end 
  
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t</select>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t</td>")}
end


def create_additional_text(additional_text)
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t<tr>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t<td colspan =2>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t<div class='fine-print'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t\t<section>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t\t\t<p>#{additional_text}</p>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t\t</section>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t</div>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t</td>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t</tr>")}
end


def create_table
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t<form method='POST'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t<table>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t<tr>")}
end


def close_table(additional_text)
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t</tr>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t<tr>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t<td width='525' colspan='2'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t\t<input type='submit' value='Submit' name='B1' onclick='return validate_form()'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t\t</td>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t</tr>")}

  if additional_text != ''
    create_additional_text(additional_text)
  end

  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t</table>")}  
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t</form>")}
end


#Create Form Fields
data = open_file

additional_text = data[0]['Copy']['AdditionalText']

create_table
create_fields(data)
close_table(additional_text)