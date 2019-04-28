require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @image = images(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Image.count' do
      post images_path, params: { image: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Image.count' do
      delete image_path(@image)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    image = images(:ants)
    assert_no_difference 'Image.count' do
      delete image_path(image)
    end
    assert_redirected_to root_url
  end
end
