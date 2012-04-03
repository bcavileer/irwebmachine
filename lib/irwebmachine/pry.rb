module IRWebmachine::Pry
  require "pry"
  require_relative "pry/command"
  require_relative "pry/nav"
  require_relative "pry/print_stack"
  require_relative "pry/enter_stack"
end

def app
  IRWebmachine.app || raise(RuntimeError, "No app set. Use IRWebmachine.app= to set one.", []) 
end
