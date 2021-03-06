require 'spec_helper'

describe_with_capybara "Belongs To" do

  let(:user){ User.create(:first_name => "John", :last_name => "Doe", :username => "johndoe") }
  let(:post){ user.posts.create :title => "Hello World", :body => "woot!"}

  before do
    # Make sure both are created
    user
    post
  end

  describe "the index page" do
    before do
      visit admin_user_posts_path(user)
    end

    describe "the main content" do
      it "should display the default table" do
        page.should have_content(post.title)
      end
    end

    describe "the view links" do
      it "should take you to the sub resource" do
        click_link "View"
        current_path.should == "/admin/users/#{user.id}/posts/#{post.id}"
      end
    end
  end

end
