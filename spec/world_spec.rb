require_relative 'spec_helper'
require_relative '../toy_robot'

describe ToyRobot::World do
  let(:world) { ToyRobot::World.new }
  let(:robot) { world.robot         }
  let(:place) { "PLACE 0,0,SOUTH"   }
  let(:bad_place) { "PLACE 0,0"   }

  it "ignores an invalid command" do
    world.command(place)
    check_robot 0, 0, :south
    world.command('nonsense')
    check_robot 0, 0, :south
  end

  it "ignores a place command with the wrong number of params" do
    world.command(place)
    check_robot 0, 0, :south
    world.command(bad_place)
    check_robot 0, 0, :south
  end

  describe ToyRobot::Robot do
    let(:move)   { "MOVE"   }
    let(:left)   { "LEFT"   }
    let(:right)  { "RIGHT"  }
    let(:report) { "REPORT" }
    
    it "has no location until placed" do
      expect(robot.x).to be_nil
    end
    
    it "won't respond to a valid command until placed" do
      world.command(move)
      world.command(left)
      world.command(right)
      expect(robot.x).to be_nil
      expect(STDOUT).not_to receive(:puts)
      world.command(report)
    end

    it "will respond to a valid command once placed" do
      world.command(place)
      world.command(left)
      check_robot 0, 0, :east
      world.command(move)
      check_robot 1, 0, :east
      world.command(left)
      check_robot 1, 0, :north
      expect(STDOUT).to receive(:puts).with "Robot is at point 1, 0, and is facing north"
      world.command(report)
    end

    describe "constrained to the world (and with whitespace in commands)" do
      let(:tls)  { place                }
      let(:tlw)  { "PLACE  0,4, WEST"   }
      let(:bre)  { "PLACE 4, 0,  EAST"  }
      let(:brs)  { "PLACE 4,  0, south" }
      let(:off)  { "PLACE 11,11, SOUTH" }
      let(:lost) { "PLACE 1,1, LOST"    }
      
      it "won't fall off the top edge" do
        world.command(tls)
        check_robot 0, 0, :south
        world.command(move)
        check_robot 0, 0, :south
      end

      it "won't fall off the left edge" do
        world.command(tlw)
        check_robot 0, 4, :west
        world.command(move)
        check_robot 0, 4, :west
      end

      it "won't fall off the right edge" do
        world.command(bre)
        check_robot 4, 0, :east
        world.command(move)
        check_robot 4, 0, :east
      end

      it "won't fall off the bottom edge" do
        world.command(brs)
        check_robot 4, 0, :south
        world.command(move)
        expect(robot.x).to eq 4
        check_robot 4, 0, :south
      end

      it "won't place a robot off the edge of the world" do
        world.command(off)
        expect(robot.x).to be_nil
      end

      it "won't place a robot with an unknown direction" do
        world.command(lost)
        expect(robot.x).to be_nil
      end

      describe "examples from the test" do
        let(:start)  { "PLACE 0,0,NORTH" }
        let(:start_c)  { "PLACE 1,2,EAST" }
        let(:move)   { "MOVE" }
        let(:left)   { "LEFT" }
        let(:report) { "REPORT" }
        let(:output_a) { "Robot is at point 0, 1, and is facing north" }
        let(:output_b) { "Robot is at point 0, 0, and is facing west" }
        let(:output_c) { "Robot is at point 3, 3, and is facing north" }
        
        it "runs example (a)" do
          world.command start
          world.command move
          expect(STDOUT).to receive(:puts).with output_a
          world.command report
        end
        
        it "runs example (b)" do
          world.command start
          world.command left
          expect(STDOUT).to receive(:puts).with output_b
          world.command report
        end
        
        it "runs example (c)" do
          world.command start_c
          world.command move
          world.command move
          world.command left
          world.command move
          expect(STDOUT).to receive(:puts).with output_c
          world.command report
        end
      end

    end

  end
end
