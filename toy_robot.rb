module ToyRobot
  class App
    attr_reader :world
    def initialize
      start
    end

    private

    def ask
      print "> "
      STDIN.gets
    end

    def introduction
      puts <<-eos
Welcome to the Toy Robot Simulator.

Commands:
  PLACE x, y, f - Place the robot on the board at point x,y, facing f
                  0, 0 is at the left, bottom of the board.
                  f is one of NORTH, SOUTH, EAST, or WEST
  MOVE          - Move the robot one square
  LEFT or RIGHT - Turn the robot left or right
  REPORT        - Output the current position and facing of the robot.

To exit simply crtl-C.
      eos
    end
    
    def farewell
      puts "\nBye bye"
    end
    
    def start
      introduction
      @world = World.new
      while world
        begin
          world.command(ask)
        rescue SystemExit, Interrupt
          @world = nil
        end
      end
      farewell
    end

  end
  
  class Command
    VALID = %w(place left right move report)
    attr_reader :command, :params
    
    def initialize(command, params = [])
      @command = command.to_sym
      @params = params
    end

    def self.parse(command_string)
      arr = command_string.downcase.strip.split(/\s/, 2).map(&:strip)
      command = arr.shift
      params = arr.empty? ? [] : arr[0].split(/,/).map(&:strip)
      return nil unless VALID.include?(command)
      Command.new(command, params)
    end
  end
  
  class World
    attr_reader :robot
    def initialize
      @robot = Robot.new(self)
      @max = 4
    end
    
    def allowed?(x, y)
      x.between?(0, max) and y.between?(0, max)
    end

    def command(command_string)
      com = Command.parse(command_string.strip)
      return unless com
      case com.command
      when :place
        robot.place(com.params[0].to_i, com.params[1].to_i, com.params[2].to_sym) if com.params.length == 3
      when :move
        robot.move
      when :left
        robot.turn(:left)
      when :right
        robot.turn(:right)
      when :report
        robot.report
      end
    end

    private
    attr_reader :max

  end
  
  class Robot
    attr_reader :x, :y, :f
    DIRECTIONS = {
      north: { x:  0, y:  1, left: :west,  right: :east  },
      south: { x:  0, y: -1, left: :east,  right: :west  },
      east:  { x:  1, y:  0, left: :north, right: :south },
      west:  { x: -1, y:  0, left: :south, right: :north }
    }
    def initialize(world)
      @world = world
      @x = nil
      @y = nil
      @f = nil
    end
    
    def placed?
      !@x.nil?
    end
    
    def place(an_x, a_y, an_f)
      return unless world.allowed?(an_x, a_y) and DIRECTIONS[an_f]
      @x = an_x
      @y = a_y
      @f = an_f
    end
    
    def move
      return unless placed?
      new_x = x + DIRECTIONS[f][:x]
      new_y = y + DIRECTIONS[f][:y]
      return unless world.allowed?(new_x, new_y)
      @x = new_x
      @y = new_y
    end
    
    def turn(a_turn)
      return unless placed?
      @f = DIRECTIONS[f][a_turn]
    end
    
    def report
      return unless placed?
      puts "Robot is at point #{x}, #{y}, and is facing #{f}"
    end
    
    private
    
    attr_reader :world
  end
  
end

if __FILE__ == $0
  $stdout.sync = true
  app = ToyRobot::App.new
end
