require 'test_helper'

class ImagesInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "image interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Image.count' do
      post images_path, params: { image: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This micropost really ties the room together"
    assert_difference 'Image.count', 1 do
      post images_path, params: { image: { content: content}} 
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_image = @user.images.paginate(page: 1).first
    assert_difference 'Image.count', -1 do
      delete image_path(first_image)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
