
require "gosu"
require_relative "jdv"

class MainWindow < Gosu::Window
    WIDTH = 800
    HEIGHT = 600
    SIZE = 20

    def initialize nb_etapes=15
        super WIDTH, HEIGHT, false
        self.caption = "JDV"

        @board = Board.new WIDTH/SIZE, HEIGHT/SIZE
        @mx, @my = 0, 0
        @nb_etapes = nb_etapes
        @launch = false
    end

    def needs_cursor?
        return true
    end

    def draw_square x, y, size, color
        self.draw_quad(x, y, color, size+x, y, color, x, size+y, color, size+x, size+y, color) 
    end

    def draw
        #Background blanc
        self.draw_quad(
            0, 0, Gosu::Color::WHITE,
            WIDTH, 0, Gosu::Color::WHITE,
            0, HEIGHT, Gosu::Color::WHITE,
            WIDTH, HEIGHT, Gosu::Color::WHITE
        )
        #self.draw_square(50, 50, SIZE, Gosu::Color::BLACK)

        @board.board.to_a.each_with_index do |r, i|
            r.each_with_index do |c, ii|
                if c.alive then
                    self.draw_square(SIZE*i, SIZE*ii, SIZE-4, Gosu::Color::BLACK)
                else
                    self.draw_line(0, SIZE*ii, Gosu::Color::BLACK, WIDTH, SIZE*ii, Gosu::Color::BLACK)
                end
            end
            self.draw_line(SIZE*i, 0, Gosu::Color::BLACK, SIZE*i, HEIGHT, Gosu::Color::BLACK)
        end

        if @launch then
            @board.next
            sleep(0.5)
        end

    end

    def button_down(id)
        if id == Gosu::KbSpace then
            @launch = !@launch
        end
    end

    def update
        @mx = (self.mouse_x / SIZE).to_i
        @my = (self.mouse_y / SIZE).to_i
        if self.button_down? Gosu::MsLeft
            @board.board[@mx, @my].alive = true
        elsif self.button_down? Gosu::MsRight
            @board.board[@mx, @my].alive = false
        end
    end
end

mainwin = MainWindow.new
mainwin.show
