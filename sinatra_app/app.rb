require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'redis'

set :bind, '0.0.0.0'
set :database, {
  adapter: 'postgresql',
  encoding: 'unicode',
  host: '127.0.0.1',
  database: 'sinatra_app',
  pool: 2,
  username: ENV['DB_USER'],
  password: ENV['DB_PASSWORD']
}

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

get '/' do
  redis = Redis.new
  connected_to_redis = true
  connected_to_pg = true

  begin
    redis.ping
  rescue StandardError => e
    logger.error(e.inspect)
    connected_to_redis = false
  end

  begin
    database.connection
  rescue StandardError => e
    logger.error(e.inspect)
    connected_to_pg = false
  end

  guest_book_entries = GuestBookEntry.all

  erb :index, :locals    => {
    :request_hash        => request.env,
    :redis               => redis,
    :connected_to_redis  => connected_to_redis,
    :connected_to_pg     => connected_to_pg,
    :guest_book_entries  => guest_book_entries,
  }
end

post '/guest_book_entries' do
  name = params[:name]
  comment = params[:comment]
  begin
    GuestBookEntry.create!(name: name, comment: comment)
  rescue => e 
    logger.error(e.inspect)
  end
  redirect "/"
end

get "/reset" do
  redis = Redis.new
  redis.set("counts", 0) 
  redirect "/"
end
