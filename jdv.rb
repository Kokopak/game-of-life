require "matrix"
 
class Matrix
    def []=(r, c, x)
        @rows[r][c] = x
    end
end
 
class Cell
    attr_accessor :alive, :voisins
    attr_reader :row, :column
 
    def initialize row, column
        @alive = false
        @row = row
        @column = column
        @voisins = []
    end
     
    def alive?
        @alive
    end
end
 
class Board
    attr_accessor :board
 
    def initialize width, height
        @width = width
        @height = height
        @board = Matrix.build(@width, @height){|row, column| Cell.new row, column}
    end
 
    def show_board
        s = ""
        @board.to_a.each do |r|
            r.each_with_index do |el, i|
                if el.alive?
                    r[i] = 0 
                else
                    r[i] = " " 
                end
            end
            s += "#{r.join(" ")}\n"
        end
        s
    end
 
    def get_voisins
        nb = 0
        voisins = Matrix[
            [-1, -1], [-1, 0], [-1, 1],
            [0, -1], [0, 1],
            [1, -1], [1, 0], [1, 1]
        ]
        @board.each do |cellule|
            voisins.row_count.times do |i|
                voisin = voisins.row(i)
                cell = Vector[cellule.row, cellule.column]
                pos = voisin + cell
                if pos[0] != @width and pos[1] != @height then
                    if @board[pos[0], pos[1]].alive?
                        cellule.voisins << @board[pos[0], pos[1]]
                    end
                end
            end
        end
    end
 
    def next
        get_voisins
        @board.each do |e|
            if e.alive?
                if e.voisins.length < 2 or e.voisins.length > 3 then
                    e.alive = false
                end
            else
                if e.voisins.length == 3 then
                    e.alive = true
                end
            end
            e.voisins = []
        end
        @board
    end
end
 
#b = Board.new 10, 10
## 
###Planeur
##b.board[4,4].alive = true
##b.board[5,5].alive = true
##b.board[6,3].alive = true
##b.board[6,4].alive = true
##b.board[6,5].alive = true
##
##Grenouille
#b.board[4, 4].alive = true
#b.board[4, 5].alive = true
#b.board[4, 6].alive = true
#b.board[3, 5].alive = true
#b.board[3, 6].alive = true
#b.board[3, 7].alive = true
##
## 
#for i in (0..15) do
#    puts b.show_board
#    b.next
#    sleep(0.5)
#end
