require_relative 'greetings'
require 'colorize'

module SampleAppRuby
    def self.main
        puts "Hello world from Ruby!"
        puts Greetings.hello
        
        puts "This is a yellow message".colorize(:yellow)
        puts "This is a green message".colorize(:green)        
    end
end

if __FILE__ == $0
    SampleAppRuby.main
end
