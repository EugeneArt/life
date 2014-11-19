require "sinatra"
require_relative "game_of_life.rb"

get('/') {erb :form}	
get('/game_over'){erb :game_over}

post '/form' do
	@@n = params[:message1].to_i
	@@m = params[:message2].to_i
	@@life = Game_of_life.new(@@n,@@m)
	@@seed = @@life.origin_of_life
	erb :seed
end

post '/next' do
	@@life.rules
	if @@life.the_end?
		redirect '/game_over'
	else
	@@seed = @@life.step
	@@tick = @@life.tick
	erb :next
	end
end