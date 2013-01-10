#!/usr/bin/env ruby

require 'open-uri'
require 'readline'

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

@topics = []

def show_topics
  @topics.each_with_index do |t, idx|
    puts "[#{idx}] #{t.title}"
  end
  puts "[exit] to end topics."
end

open('http://www.yahoo.co.jp') do |f|
  f.read.scan(/topics.+?\*-([^<]+?)</) do |m|
    next if /backnumber|photograph/ =~ m.first

    ary = m.first.split('">')
    @topics << Topic.new do |t|
      t.url = ary[0]
      t.title   = ary[1]
    end
  end
end

show_topics

while buf = Readline.readline("> ", false)
  break if buf == 'exit'
  unless /^[0-9]+$/ =~ buf && @topics.length > buf.to_i
    puts "[ERROR] You must input NUMBER from 0 to #{@topics.length-1}."
    next
  end
  @topics[buf.to_i].show
  puts "=================================="
  show_topics
end
