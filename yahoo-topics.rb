#!/usr/bin/env ruby

require 'open-uri'

class Topic
  attr_accessor :title, :body, :url

  def initialize
    yield self
  end
end

topics = []

open('http://www.yahoo.co.jp') do |f|
  f.read.scan(/topics.+?\*-([^<]+?)</) do |m|
    next if /backnumber|photograph/ =~ m.first

    ary = m.first.split('">')
    topics << Topic.new do |t|
      t.url = ary[0]
      t.title   = ary[1]
    end
  end
end

topics.each do |t|
  puts "#{t.title} - #{t.url}"
end
