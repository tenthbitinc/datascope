require 'sinatra'
require 'sequel'
require 'json'
require 'uri'
DB = Sequel.connect ENV['TARGET_DB']

class Datascope < Sinatra::Application
  get '/' do
    haml :index
  end

  get '/history.json' do
    time = Time.now - 2*60*60
    (0..120).map do |t|
      {
        time: time + t*60,
        connections: {count: (12*t/160).to_i}
      }
    end.to_json
  end

  get '/stats.json' do
    {
      time: Time.now,
      connections: {count: count}
    }.to_json
  end


  def count
    DB[:pg_stat_activity].count
  end

  def cache_hit
    DB
  end
end