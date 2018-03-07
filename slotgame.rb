class SlotGame
  SLOT_SYMBOLS = %w[! @ # $ % ^ & * +]
  RESPONSES = ["y", "yes", "ok", "go", ""]


  def initialize(balance =nil) #--------------------------------############
    unless balance
      begin
        print "How much $$ would you like to add to your slots wallet? "
        @initial_input = gets.chomp.to_i
        if @initial_input <= 0
          puts "You must have a postive balance in your slots wallet to play!"
        else end
      end until @initial_input > 0
    end
    @balance = @initial_input
  end


  def one_spin #---------------------------------------------------
    puts "Total balance: $#{@balance}"
    begin
      
      print "How much would you like to bet? "
      bet = gets.to_i
      puts "You only have $#{@balance}!" if bet > @balance
    end until bet <= @balance
    @balance -= bet

    results = 3.times.map{ SLOT_SYMBOLS.sample }
    puts "\n~~~|  #{results.join('  |  ')}  |~~~"
    winnings = bet * multiplier(results)

    if winnings>0
      @balance += winnings
      puts "\nYou just won $#{winnings}! \nTotal balance: $#{@balance}"
    else
      puts "\nNo matches!"
    end
  end


  def playing #---------------------------------------------------
    begin
      one_spin
    end while @balance > 0 && keep_playing?

    if @balance > @initial_input
      puts "You are ending with $#{@balance}. That's a profit of $#{@balance - @initial_input}!"
    else
      puts "You are ending with $#{@balance}"
    end
  end



  def keep_playing? #---------------------------------------------------
    print "Play again?"
    RESPONSES.include?(gets.chomp.downcase)
  end


  private

  def multiplier(*tokens) #-------------------------------------############
    case tokens.flatten.uniq.length
      when 1 then 3
      when 2 then 2
      else 0
    end
  end
end


# tokens.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
# case total
#   when 2 then bet * 2
#   when 3 then bet * 3
#   else bet * 1
# end




















SlotGame.new.playing if __FILE__==$0 ############
