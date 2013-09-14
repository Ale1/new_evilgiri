get '/' do
  
  erb :index
end


post '/scan' do
start_time = Time.now 
@treasure ={}
(31600..31625).each do |elo_id|
begin
page = Nokogiri::HTML(open('http://www.elophant.com/league-of-legends/summoner/na/'+elo_id.to_s)) 
swipe = {
  :handle => page.css('h2').first.content,
  :level => page.css('h3').first.content.level_scraper,
  :record_wins => page.css('span.high').first.content.str_to_i
} 
@treasure[elo_id] = swipe unless swipe.empty? 
rescue StandardError
  next
end
end
end_time = Time.now
@timer = end_time - start_time
@counter = @treasure.count
erb :index
end



get '/stop' do

redirect '/'
end
