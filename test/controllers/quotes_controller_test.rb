require "test_helper"

class QuotesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get quotes_index_url
    assert_response :success
  end

  test "should get show" do
    get quotes_show_url
    assert_response :success
  end

  test "should get new" do
    get quotes_new_url
    assert_response :success
  end

  test "should get create" do
    get quotes_create_url
    assert_response :success
  end

  test "should get vote" do
    get quotes_vote_url
    assert_response :success
  end

  test "should get increment_views" do
    get quotes_increment_views_url
    assert_response :success
  end

  test "should get random" do
    get quotes_random_url
    assert_response :success
  end

  test "should get jokes" do
    get quotes_jokes_url
    assert_response :success
  end

  test "should get inspiring" do
    get quotes_inspiring_url
    assert_response :success
  end
end
