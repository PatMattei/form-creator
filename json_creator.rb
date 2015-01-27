require 'xlsx2json'
require 'json'

json_path = 'fields.json'
excel_path = 'posting-docs.xlsx'
sheet_number = 0 # sheet number start from 0
header_row_number = 1 # row number of the header row which contains column names. 
                      # Rows before this number get ignored. 
                      # Row numbers start from 1 based on Excel conventions.

Xlsx2json::Transformer.execute excel_path, sheet_number, json_path, header_row_number: header_row_number

JSON.parse(File.open(json_path).read) # => [{"sku"=>"P07", "bu"=>"Paper", "sales"=>"200", "year"=>"2008"}, {"sku"=>"P17", "bu"=>"Paper", "sales"=>"200", "year"=>"2014"}, {"sku"=>"P19", "bu"=>"Paper", "sales"=>"200", "year"=>"2008"}]