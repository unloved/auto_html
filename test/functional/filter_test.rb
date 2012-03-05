require File.expand_path('../../test_helper', __FILE__)
require File.expand_path('../../fixture_setup', __FILE__)

AutoHtml.add_filter(:foo) do |text|
  nil
end

AutoHtml.add_filter(:bar) do |text|
  self.flag = self.flag.to_i + 1
  "bar"
end

class User < ActiveRecord::Base
  attr_accessor :flag

  auto_html_for :bio do
    foo
    foo
    bar
  end
end

class FilterTest < Test::Unit::TestCase
  include FixtureSetup

  def test_transform_after_save
    @article = User.new(:bio => 'in progress...')
    assert_equal 'bar', @article.bio_html
  end

  def test_access_object
    @article = User.new(:bio => 'in progress...')
    @article.bio_html

    # reexecute filter
    @article.bio_html = nil
    @article.bio_html

    assert_equal 2, @article.flag
  end
end
