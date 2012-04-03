module IRWebmachine::Pry
  Nav = Pry::CommandSet.new do
    command "finish" do
      throw(:breakout, :finish)
    end

    command "next" do
      throw(:breakout, :next)
    end

    command "prev" do
      _pry_.binding_stack.pop
    end 
  end
end

IRWebmachine::Pry::Nav.import(Pry.commands)