require 'test_helper'

class ImageTest < ActiveSupport::TestCase
 def setup
    @user = users(:michael)
    @image = Image.new(content: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert_not @image.valid?
  end

  test "user id should be present" do
    @image.user_id = nil
    assert_not @image.valid?
  end
  
  test "content should be present" do
    @image.content = "   "
    assert_not @image.valid?
  end

  test "content should be at most 140 characters" do
    @image.content = "a" * 141
    assert_not @image.valid?
  end
  
  test "order should be most recent first" do
    assert_equal images(:most_recent), Image.first
  end
end
