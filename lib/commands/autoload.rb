path = File.dirname(__FILE__)

Dir.glob(path+'/*') do |fileName|
    next if(!fileName.match(/\/autoload\.rb$/).nil?)
    require fileName if(!fileName.match(/\.rb$/).nil?)
end