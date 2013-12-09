require 'coffee-script'

desc "concats the coffee subscripts"
task :mix_coffee do
  sh "coffeescript-concat -I coffee -o mixed_coffee/traveller2min.coffee"
end

desc 'downloads and installs c3dl'
task :install do
  c3dl = 'c3dl-2.2.zip'
  exec "curl -O http://www.c3dl.org/wp-content/releases/#{c3dl};
        unzip #{c3dl};
        mv c3dl canvas3dapi;
        rm #{c3dl}"
end

desc 'Opens traveller.html in your default browser'
task :open do
  exec 'xdg-open executable/traveller.html'
end

desc 'Compiles the current coffeescript code to js'
task :compile do
  File.open('executable/traveller2min.js', 'w') do |f|
    f.puts CoffeeScript.compile(File.read("coffee/traveller2min.coffee"))
  end
end
