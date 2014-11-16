puts "size"
@n=gets.to_i
@m=gets.to_i
puts "alive"
seed_num= gets.to_i

@empty = "."
@live = "X"
@gen = 0
@action=[[],[],[]]
ty=[]
def size(n,m)
  life=Array.new(n){Array.new(m,@empty)}
end

def filling_seed(life_seed,qt)
  qt.times do
    x = rand(@n)
    y = rand(@m)
    life_seed[x][y] = @live
  end
end

def limit?(index_x,index_y)
  return false if index_x<0
  return false if index_y<0
  return false if index_x>=@n
  return false if index_y>=@m
  return true
end

def neighbors(x,y,life_m)
  count = 0
    (-1..1).each do |h|
      (-1..1).each do |k|
        if limit?(x+k,y+h)
          if life_m[x+k][y+h] == @live
            count+=1
          end
        end 
      end
    end
if life_m[x][y] == @live && count>0 
  count-=1
end
return count
end

def rules_life(ii,jj,board,n_count)
    if board[ii][jj] == @empty && n_count == 3
        @action[0] << ii
        @action[1] << jj
        @action[2] << @live
      end
    if board[ii][jj] == @live && n_count == (2..3)
        @action[0] << ii
        @action[1] << jj
        @action[2] << @live
      elsif board[ii][jj] == @live && (n_count >3 || n_count <2)
        @action[0] << ii
        @action[1] << jj
        @action[2] << @empty
    end
return @action
end

def print_generation(desk,life)
  desk[0].each_index {|i| life[desk[0][i]][desk[1][i]]=desk[2][i]}
end

def generation(life_s,gen)
  puts "Generation:#{gen}"
end

life=size(@n,@m)
filling_seed(life,seed_num)

(0...@n).each do |i|
  (0...@m).each do |j|
    print life[i][j]
  end 
  puts
end

loop do
  @gen+=1
(0...@n).each do |i|
  (0...@m).each do |j|
    num_neighbors = neighbors(i,j,life)
    ty= rules_life(i,j,life,num_neighbors)
  end 
end

  print_generation(ty,life)

(0...@n).each do |i|
  (0...@m).each do |j|
    print life[i][j]
  end 
 puts 
end
generation(life,@gen)
  sleep 1
 puts "\e[H\e[2J"
end