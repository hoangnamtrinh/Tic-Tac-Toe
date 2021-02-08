class Array
    def all_same?
        self.all? { |element| element == self[0] }
    end
    def any_empty?
        self.any? do |element|
            for i in (1..9) do
                if element == i
                    return true
                end
            end
            false
        end 
    end
    def none_empty?
        !any_empty?
    end
end

class Board
    attr_accessor :board
    def initialize
        @board = [[1, 2, 3], 
                  [4, 5, 6], 
                  [7, 8, 9]]
    end

    def print_board
        n = 0
        for i in board do
            for j in i do
                if n < 3 
                    print j
                    print "   "
                    n += 1
                else
                    puts
                    puts
                    print j
                    print "   "
                    n = 1
                end    
            end          
        end
    end

    def get_cell(x, y)
        board[x][y]
    end

    def set_cell(pos, value)
        board[pos[0]][pos[1]] = value
    end
    
    def game_over?
        return false if winner?
        return false if draw?
    end

    def draw?
        board.flatten.none_empty? ? true : false
    end

     
    def winner?
        diagonals = [
            [get_cell(0, 0), get_cell(1, 1), get_cell(2, 2)],
            [get_cell(0, 2), get_cell(1, 1), get_cell(2, 0)]
          ]
        for i in board do
            if i.all_same?
                return true
            end
        end

        for i in board.transpose do
            if i.all_same?
                return true
            end
        end

        for i in diagonals do
            if i.all_same?
                return true
            end
        end
        false
    end

end

class Players
    attr_accessor :name, :sym
    def initialize(name, sym)
        @name = name
        @sym = sym
    end

    
end

class Game
    attr_accessor :board
    def initialize(board=Board.new)
        @board = board
    end
    
    

    def play
        mapping = {
            "1" => [0, 0],
            "2" => [0, 1],
            "3" => [0, 2],
            "4" => [1, 0],
            "5" => [1, 1],
            "6" => [1, 2],
            "7" => [2, 0],
            "8" => [2, 1],
            "9" => [2, 2]
        }
        current_player = Players.new("player1", "X")
        other_player = Players.new("player2", "O") 
        board.print_board

        while true
            while true
                print "Choose where to put #{current_player.sym}: "
                pos = gets.chomp.to_s

                if ((pos.to_i.between?(1, 9)) == false)
                    puts "between 1-9"
                elsif (board.get_cell(mapping[pos][0], mapping[pos][1]) == "X" or 
                    board.get_cell(mapping[pos][0], mapping[pos][1]) == "O") 
                    puts "that's already occupied"
                else
                    break
                end
            end
            board.set_cell(mapping[pos], current_player.sym)
            puts "---------"
            board.print_board
            if board.winner?
                p "#{current_player.sym} wins"
                exit
            elsif board.draw?
                p "draw"
                exit
            else current_player, other_player = other_player, current_player
            end
        end
    end

end

game = Game.new
game.play

