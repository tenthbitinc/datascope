require './app'
require 'rack/coffee'

use Rack::Coffee

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == [ENV['HTTP_USER'], ENV['HTTP_PASS']]
end

run Datascope

