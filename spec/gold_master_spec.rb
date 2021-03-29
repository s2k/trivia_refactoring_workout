require 'rspec'

def golden_master(i)
  File.read(File.join(File.dirname(__FILE__), 'test_data', "golden_master-#{i}.txt"))
end

def seed_generator(i)
  11 + i * 41
end

RSpec.describe 'Running the game from the command line' do
  5.times do |i|
    it "should replay the same game with a random seed Nr. #{i}" do
      game_output = `#{File.join(File.dirname(__FILE__), '..', 'bin', 'trivia')} #{seed_generator(i)}`
      expect(game_output).to eq golden_master(i)
    end
  end
end
