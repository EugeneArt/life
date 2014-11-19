#!/usr/bin/env ruby

class Game_of_life

	def initialize(n,m)
		@n = n
		@m = m
		@empty = "."
		@live  = "X"
		@gen = 0
	end

	def origin_of_life
		@amend = Array.new(@n){Array.new(@m,@empty)}
		@board = Array.new(@n){Array.new(@m){rand(2) == 0 ? @live : @empty}}
	end

	def limit?(index_x,index_y)
	  return false if index_x<0
	  return false if index_y<0
	  return false if index_x>=@n
	  return false if index_y>=@m
	  return true
	end

	def neighborhood(row,col)
		count = 0
		(-1..1).each do |r|
		 (-1..1).each do |c|
			  if limit?(row+r,col+c)
			 			count+=1 if @board[row+r][col+c] == @live 
			  end
			end
		end
		count-=1 if @board[row][col] == @live
		return count
	end

	def rules
		(0...@n).each do |i|
		  (0...@m).each do |j|
		    num = neighborhood(i,j)
		    	if num == 3 && @board[i][j] == @empty
						@amend[i][j] = @live
					elsif (num < 2 || num > 3) && @board[i][j] == @live
						@amend[i][j] = @empty
					else
						@amend[i][j] = @board[i][j] 
					end							
		  end 
		end
		return @amend
	end

	def the_end?
		if @board == @amend
			return true
		end
	end

	def step
		(0...@n).each do|i|
			(0...@m).each do|j|
					@board[i][j] = @amend[i][j]
			end
		end
		return @board
	end

	def show
		(0...@n).each do |i|
		  (0...@m).each do |j|
		    print @board[i][j]
		  end 
		 puts 
		end
	end

	def tick
		@gen+=1
	end

	def play
		generation = 0
		origin_of_life
		loop do
			generation+=1
			puts "\e[H\e[2J"
			rules
			break if the_end?
			step
			show	
			sleep 0.7
		end
		puts "There was #{@gen-=1} generations"
	end
end

#l = Game_of_life.new(13,13)
#l.play