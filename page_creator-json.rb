require 'json'
require 'rubygems'
require 'mechanize'

def open_file
  json_file = File.read('fields.json')
  parsed_file = JSON.parse(json_file)
end


def create_page(school_name)
  File.open('new/form.htm', 'a+') {|f| f.write("<!DOCTYPE html>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n<html>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n<head>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t<link rel='stylesheet' type='text/css' href='../forms.css'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t<script type='text/javascript' src='form_validation.js'></script>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t<title>#{school_name}</title>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n</head>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n")}
end

def create_left(school_name, copy, disclaimer)
  File.open('new/form.htm', 'a+') {|f| f.write("<body>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t<div id='container'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t<div id='main'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t<div id='left'>")}
  create_copy(school_name, copy, disclaimer)
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t</div>")}
end

def create_copy(school_name, copy, disclaimer)
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t<div class='logo-area'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t<img src='images/school-logo.png' alt='#{school_name}' border='0'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t</div>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t<hr color='#CCCCCC' size='0'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t<div class='photo-area'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t<p align='center'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t<img border='0' src='images/student.jpg' width='425' height='282'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t</p>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t</div>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t<hr color='#A2C0DF' size='1'>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t<h1>#{school_name}</h1>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t<section>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t#{copy}")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t</section>")}
  
  if disclaimer != ""
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t<div class='fine-print'>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t<section>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t\t<p>#{disclaimer}</p>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t</section>")}
    File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t</div>")}
  end
end


def create_right(school_name)
File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t<div id='right'>")}
File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t<div class='requestformheader'>")}
File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t<p align='center'>")}
File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t<img src='images/request.jpg' width='481' height='114'>")}
File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t<br>")}
File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\t<br>")}
File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t\tComplete this form to learn more about #{school_name}")}
File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t\t</p>")}
File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t\t</div>")}
system('ruby table_creator-json.rb')
end

def close_page
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t\t</div>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n\t</div>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n</body>")}
  File.open('new/form.htm', 'a+') {|f| f.write("\n</html>")}
end

#create HTML page
data = open_file
school_name = data[0]['SchoolName']
copy = data[0]['Copy']['CopyText']
disclaimer = data[0]['Copy']['DisclaimerText']

create_page(school_name)
create_left(school_name, copy, disclaimer)
create_right(school_name)
close_page