require_relative '../game'

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#roll' do
    it 'rolls' do
      game.roll(1)
    end
  end

  describe '#get_score' do
    before { game.rolls.map { 0 } }

    it 'shows score' do
      expect(game.get_score).to eql(0)
    end

    context 'when score is not zero' do
      before { game.roll(8) }

      it 'shows score' do
        expect(game.get_score).to eql(8)
      end
    end

    context 'when spare' do
      let(:spare) { 2.times {game.roll(5)} }

      it 'shows score with spare' do
        spare
        game.roll(3)
        17.times { game.roll(0) }

        expect(game.get_score).to eql(16)
      end
    end

    context 'when strike' do
      let(:strike) { game.roll(10) }

      it 'shows score with strike' do
        strike
        game.roll(3)
        game.roll(4)
        16.times { game.roll(0) }

        expect(game.get_score).to eql(24)
      end
    end

    context 'perfect game' do
      it 'when all strikes' do
        12.times {game.roll(10)}

        expect(game.get_score).to eql(300)
      end
    end
  end
end
