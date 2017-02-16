require 'byebug'

class Game
  attr_accessor :score, :rolls, :current_roll

  def initialize
    self.score        = 0
    self.current_roll = 0
    self.rolls        = Array.new(20, 0)
  end

  def roll(pins)
    rolls[current_roll] = pins
    self.current_roll += 1
  end

  def get_score
    first_in_frame = 0
    frames         = 10

    frames.times do
      if strike?(first_in_frame)
        self.score += (10 + next_two_balls_for_strike(first_in_frame))
        first_in_frame += 1
      elsif spare?(first_in_frame)
        self.score += (10 + next_ball_for_spare(first_in_frame))
        first_in_frame += 2
      else
        self.score += (rolls[first_in_frame] + rolls[first_in_frame + 1])
        first_in_frame += 2
      end
    end
    self.score
  end

  private

  def next_ball_for_spare(first_in_frame)
    rolls[first_in_frame + 2]
  end

  def next_two_balls_for_strike(first_in_frame)
    rolls[first_in_frame + 1] + next_ball_for_spare(first_in_frame)
  end

  def strike?(first_in_frame)
    rolls[first_in_frame] == 10
  end

  def spare?(first_in_frame)
    rolls[first_in_frame] + rolls[first_in_frame + 1] == 10
  end
end
