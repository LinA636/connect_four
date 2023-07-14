require_relative '../lib/connectFour'

describe ConnectFour do
  subject(:game) {described_class.new}

  describe '#initialize' do
    it 'creates a field_array with 6 rows and 7 columns' do
      number_of_rows = game.field_matrix.row_size
      number_of_columns = game.field_matrix.column_size
      expect(number_of_rows).to eq(6)
      expect(number_of_columns).to eq(7)
    end

    it 'creates an array of Fields' do
      game.field_matrix.each do |field|
        expect(field).to be_instance_of(Field)
      end
    end

    it 'it initializes player1 and player2' do
      expect(game.player1).to be_instance_of(Player)
      expect(game.player2).to be_instance_of(Player)
    end

    it 'it sets current player to player1 with red symbol' do
      expect(game.current_player).to be(game.player1)
    end
  end
end