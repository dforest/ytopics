require "ytopics/version"
require 'open-uri'
require 'readline'

module Ytopics
  class Topic
    attr_accessor :title, :body, :url

    def initialize
      yield self
    end

    def show
      if self.body.nil?
        flg = false
        open(self.url, "r:euc-jp") do |f|
          f.read.encode("utf-8").scan(/<!--HBODY-->(.+?)</) {|m|self.body = m.first}
        end
      end
      puts "<#{self.title}>"
      puts self.body
    end
  end

  class << self
    @@topics ||= []

    def start
      puts "type `exit` to end ytopics"
      open('http://www.yahoo.co.jp') do |f|
        f.read.scan(/topics.+?\*-([^<]+?)</) do |m|
          next if /backnumber|photograph/ =~ m.first

          ary = m.first.split('">')
          @@topics << Topic.new do |t|
            t.url = ary[0]
            t.title   = ary[1]
          end
        end
      end

      display

      while buf = Readline.readline("ytopics> ", false)
        line = buf.strip
        break if line == 'exit'
        unless /^[0-9]+$/ =~ line && @@topics.length > line.to_i
          puts "Command not found"
          next
        end
        @@topics[line.to_i].show
        display
      end
    end

    def display
      @@topics.each_with_index do |t, idx|
        puts "[#{idx}] #{t.title}"
      end
    end
  end

end
