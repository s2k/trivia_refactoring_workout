# frozen_string_literal: true

module UglyTrivia
  class Game
    CATEGORIES = %w[Pop Science Sports Rock].freeze

    def initialize
      @players        = []
      @places         = Array.new(6, 0)
      @purses         = Array.new(6, 0)
      @in_penalty_box = Array.new(6, nil)

      @current_player                = 0
      @is_getting_out_of_penalty_box = false

      @questions = {}
      CATEGORIES.each do |category|
        @questions[category] = create_questions_for(category, 50)
      end
    end

    def play
      begin
        roll(rand(5) + 1)
        if rand(9) == 7
          not_a_winner = wrong_answer
        else
          not_a_winner = correct_answer
        end
      end while not_a_winner

    end

    def create_questions_for(topic, total_number)
      Array.new(total_number) { |i| "#{topic} Question #{i}" }
    end

    def playable?
      @players.length >= 2
    end

    def add(*player_names)
      player_names.each do |player_name|
        @players << player_name
        @places << 0
        @purses << 0
        @in_penalty_box << false

        puts "#{player_name} was added"
        puts "They are player number #{@players.length}"
      end
      true
    end

    def roll(roll)
      puts "#{current_player_name} is the current player"
      puts "They have rolled a #{roll}"

      if @in_penalty_box[@current_player]
        if roll.odd?
          @is_getting_out_of_penalty_box = true

          puts "#{current_player_name} is getting out of the penalty box"
          perform_move(roll)
        else
          puts "#{current_player_name} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false
        end

      else
        perform_move(roll)
      end
    end

    def correct_answer
      if @in_penalty_box[@current_player]
        if @is_getting_out_of_penalty_box
          correct_answer_steps
        else
          next_player
        end
      else
        correct_answer_steps
      end
    end

    def wrong_answer
      puts 'Question was incorrectly answered'
      puts "#{current_player_name} was sent to the penalty box"
      @in_penalty_box[@current_player] = true
      next_player
    end

    private

    def perform_move(roll)
      advance_played_by(roll)
      log_new_location_and_category
      ask_question
    end

    def log_new_location_and_category
      puts "#{current_player_name}'s new location is #{@places[@current_player]}"
      puts "The category is #{current_category}"
    end

    def current_player_name
      @players[@current_player]
    end

    def ask_question
      puts @questions[current_category].shift
    end

    def current_category
      CATEGORIES[@places[@current_player] % CATEGORIES.size]
    end

    def next_player
      @current_player = (@current_player + 1) % @players.length
    end

    def correct_answer_steps
      puts 'Answer was correct!!!!'
      @purses[@current_player] += 1
      puts "#{current_player_name} now has #{@purses[@current_player]} Gold Coin#{@purses[@current_player] == 1 ? '' : 's'}."

      winner = did_player_win
      next_player
      winner
    end

    def advance_played_by(roll)
      @places[@current_player] = (@places[@current_player] + roll) % 12
    end

    def did_player_win
      @purses[@current_player] != 6
    end
  end
end
