require "sinatra"

@@empty = "O"
@@live = "X"
@ty = []
def size(n,m)
  life=Array.new(n){Array.new(m,@@empty)}
end

def filling_seed(life_seed,qt)
  qt.times do
    x = rand(@size_n.to_i)
    y = rand(@size_m.to_i)
    life_seed[x][y] = @@live
  end
  return life_seed
end

def limit?(index_x,index_y)
  return false if index_x<0
  return false if index_y<0
  return false if index_x>=@size_n.to_i
  return false if index_y>=@size_m.to_i
  return true
end

def neighbors(x,y,life_m)
  count = 0
    (-1..1).each do |h|
      (-1..1).each do |k|
        if limit?(x+k,y+h)
          if life_m[x+k][y+h] == @@live
            count+=1
          end
        end 
      end
    end
if life_m[x][y] == @@live && count>0 
  count-=1
end
return count
end

def rules_life(ii,jj,board,n_count)
    if board[ii][jj] == @@empty && n_count == 3
        @action[0] << ii
        @action[1] << jj
        @action[2] << @@live
      end
    if board[ii][jj] == @@live && n_count == (2..3)
        @action[0] << ii
        @action[1] << jj
        @action[2] << @@live
      elsif board[ii][jj] == @@live && (n_count >3 || n_count <2)
        @action[0] << ii
        @action[1] << jj
        @action[2] << @@empty
    end
return @action
end

def print_generation(desk,life)
  desk[0].each_index {|i| life[desk[0][i]][desk[1][i]]=desk[2][i]}
end

get '/' do
	erb :form
end

post '/form' do
	@size_n = params[:message1]
	@size_m = params[:message2]
	@@n = @size_n
	@@m = @size_m
	@alive  = params[:message3]
	@life 	= size(@size_n.to_i,@size_m.to_i)
	@@life_seed = filling_seed(@life,@alive.to_i)
	@@life = @@life_seed 
	erb :seed
end

post '/next' do
	#(0...@@n.to_i).each do |i|
  #	(0...@@m.to_i).each do |j|
  #	 	num_neighbors = neighbors(i,j,@@life)
   #	 	rules_life(i,j,@@life,num_neighbors)
  	#end 
	#end
	# print_generation(@ty,@@life)
	erb :next
end


