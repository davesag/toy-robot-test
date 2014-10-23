require_relative 'spec_helper'
require_relative '../toy_robot'

describe ToyRobot::Command do
  
  describe "simple command" do
    let(:simple_uc)              { "MOVE"   }
    let(:simple_dc)              { "move"   }
    let(:simple_with_whitespace) { " move " }
    let(:expected_command)       { :move    }
    let(:expected_params)        { []       }

    it "parses a simple all-caps command" do
      check_command ToyRobot::Command.parse(simple_uc)
    end

    it "parses a simple downcased command" do
      check_command ToyRobot::Command.parse(simple_dc)
    end

    it "parses a simple command with extra whitespace" do
      check_command ToyRobot::Command.parse(simple_with_whitespace)
    end
  end

  describe "command with params" do
    let(:with_params)                      { "place 1,2,north" }
    let(:with_params_and_whitespace)       { "place 1, 2, north" }
    let(:with_params_and_lotsa_whitespace) { "  place   1,  2,   north " }
    let(:expected_command)                 { :place  }
    let(:expected_params)                  { %w(1 2 north) }

    it "parses a complex command" do
      check_command ToyRobot::Command.parse(with_params)
    end

    it "parses a complex command with whitespace" do
      check_command ToyRobot::Command.parse(with_params_and_whitespace)
    end
  end
end
