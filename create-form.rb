require 'rubygems'
require 'mechanize'
require 'open-uri'

def create_file
  FileUtils.remove_dir('new', true)
  Dir.mkdir 'new'
  File.new('new/form.htm', 'w')
end

def create_validation_file
  File.new('new/form_validation.js', 'w')
end

def create_folders
  Dir.mkdir 'new/images'
  download_css
end

def download_css
  open('forms.css', 'wb') do |file|
    file << open('http://www.topcollegedegrees.net/schools/forms.css').read
  end
end

def download_images
  agent = Mechanize.new
  img_required = 'http://topcollegedegrees.net/schools/template/images/req.gif'
  img_banner = 'http://topcollegedegrees.net/schools/template/images/request.jpg'
  img_student = 'http://topcollegedegrees.net/schools/template/images/student.jpg'
  img_logo = 'http://topcollegedegrees.net/schools/template/images/school-logo.png'
  
  agent.get(img_required).save 'new/images/req.gif' 
  agent.get(img_banner).save 'new/images/request.jpg' 
  agent.get(img_student).save 'new/images/student.jpg' 
  agent.get(img_logo).save 'new/images/school-logo.png' 
end

create_file
create_validation_file
create_folders
download_images
system('ruby json_creator.rb')
system('ruby page_creator.rb')
system('ruby validation_creator.rb')