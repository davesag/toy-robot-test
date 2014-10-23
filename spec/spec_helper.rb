require 'simplecov'
require 'rspec'
SimpleCov.start

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.order = "random"
end

def check_robot(x, y, f)
  expect(robot.x).to eq x
  expect(robot.y).to eq y
  expect(robot.f).to eq f
end

def check_command(com)
  expect(com.command).to eq expected_command
  expect(com.params - expected_params).to be_empty
end
