require 'helper'

class RestrictionsControllerTest < ActionController::TestCase
  tests Challah::Test::RestrictionsController

  context "The restrictions controller" do
    context "With no user" do
      setup do
        signout
      end

      should "be able to get to the index page" do
        get :index
        assert_response :success
        assert_equal nil, assigns(:current_user)
      end

      should "not be able to get to the edit page" do
        get :edit
        assert_redirected_to '/sign-in'
      end

      should "not get to the new page" do
        get :new
        assert_redirected_to '/sign-in'
      end
    end

    context "with a normal user" do
      setup do
        @user = create(:user)
        signin_as(@user)
      end

      should "get to the index page" do
        get :index
        assert_response :success
        assert_equal @user, assigns(:current_user)
      end

      should "get to the edit page" do
        get :edit
        assert_response :success
      end

      should "get to the show page" do
        get :show
        assert_response :success
      end

      should "get to the new page" do
        get :new
        assert_response :unauthorized
        assert_template 'sessions/access_denied'
      end
    end

    context "with an admin user" do
      setup do
        @user = create(:admin_user)
        @permission = create(:permission, :key => 'special')
        signin_as(@user)
      end

      should "get to the index page" do
        get :index
        assert_response :success
        assert_equal @user, assigns(:current_user)
      end

      should "get to the edit page" do
        get :edit
        assert_response :success
      end

      should "get to the show page" do
        get :show
        assert_response :success
      end

      should "get to the new page" do
        get :new
        assert_response :success
      end
    end
  end
end