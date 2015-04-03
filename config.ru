use Rack::Static, :urls => [""], :root => 'public', :index => 'index.html'
run ->{ [404, nil, nil] }
