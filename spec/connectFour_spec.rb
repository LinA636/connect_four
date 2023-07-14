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

  describe '#start_game' do
    subject(:game_start_game){described_class.new}
    before do
      allow(game_start_game).to receive(:victory?).and_return(false, false, false)
      allow(game_start_game).to receive(:moves_left?).and_return(true, true, false)
      allow(game_start_game).to receive(:update_current_player)
      allow(game_start_game).to receive(:print_board)
      allow(game_start_game).to receive(:make_move)
    end

    it 'receives #update_current_player, #print_board and #make_move as long no victoryis declared and moves are left' do
      expect(game_start_game).to receive(:update_current_player).twice
      expect(game_start_game).to receive(:print_board).twice
      expect(game_start_game).to receive(:make_move).twice
      game_start_game.start_game
    end
  end

  describe '#moves_left?' do
    subject(:game_moves_left){described_class.new}
    context 'when moves are left' do
      before do
        game_moves_left.current_player.played_discs = 20  
      end

      it 'increments the played_discs count for current player' do
        expect{game_moves_left.moves_left?}.to change{game_moves_left.current_player.played_discs}.by(1)
        game_moves_left.moves_left?
      end

      it 'returns true' do
        expect(game_moves_left.moves_left?).to be true
      end
    end

    context 'when no more moves are left' do
      before do
        game_moves_left.current_player.played_discs = 21  
        allow(game_moves_left).to receive(:announce_tie)
      end
      
      it 'receives the methods #announce_tie' do
        expect(game_moves_left).to receive(:announce_tie).once
        game_moves_left.moves_left?
      end
    end
  end

  describe '#update_current_player' do
    subject(:game_current_player){described_class.new}
    context 'when current_player is player1' do
      before do
        game_current_player.current_player = game_current_player.player1
      end

      it 'changes current_palyer to player2' do
        expect(game_current_player.update_current_player).to eq(game_current_player.player2)
      end
    end

    context 'when current_player is player2' do
      before do
        game_current_player.current_player = game_current_player.player2
      end

      it 'changes current_player to player1' do
        expect(game_current_player.update_current_player).to eq(game_current_player.player1)
     end
    end
  end

  describe '#choose_column' do
    subject(:game_choose_column){described_class.new}
    context 'when valid and non_full column is chosen' do
      before do
        allow(game_choose_column).to receive(:gets).and_return("1\n")
        allow(game_choose_column).to receive(:column_exists?).and_return(true)
        allow(game_choose_column).to receive(:column_full?).and_return(false)
      end

      it 'returns chosen coulumn index' do
        expect(game_choose_column.choose_column).to eq(0)
      end
    end

    context 'when valid, but full column is chosen' do
      before do
        allow(game_choose_column).to receive(:gets).and_return("1\n", "2\n")
        allow(game_choose_column).to receive(:column_exists?).and_return(true)
        allow(game_choose_column).to receive(:column_full?).and_return(true, false)
      end

      it 'chooses new column until column is valid and not full' do
        expect(game_choose_column.choose_column).to eq(1)
      end
    end

    context 'when invalid column is chosen' do
      before do
        allow(game_choose_column).to receive(:gets).and_return("10\n", "2\n")
        allow(game_choose_column).to receive(:column_exists?).and_return(false, true)
        allow(game_choose_column).to receive(:column_full?).and_return(false)
      end

      it 'chooses new column until column is valid and not full' do
        expect(game_choose_column.choose_column).to eq(1)
      end
    end
  end

end