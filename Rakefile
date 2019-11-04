require 'bundler'
Bundler.require

require 'yaml'
require 'pp'

desc "Generate www.latentninja.com homepage"
task :default do
  config = YAML.load(File.read('index.yml'))
  column_count = config.count

  snippet = "$column_count: #{column_count};\n"
  sass_input = snippet + File.read('index.scss')
  sass = Sass::Engine.new( sass_input, syntax: :scss, style: :compressed )
  raw_css = sass.render

  haml_input = File.read('index.haml')
  haml = Haml::Engine.new( haml_input, remove_whitespace: true )
  raw_html = haml.render( Object.new, { link_columns: config, raw_css: raw_css } )

  File.open( 'public/index.html', 'w' ) do |f|
    f.print raw_html
  end
end

desc "Start local dev server"
task :server do
  exec 'bundle exec rackup'
end
