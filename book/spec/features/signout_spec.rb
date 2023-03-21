require 'rails_helper'

RSpec.describe "Flow of signout button", type: :feature do
    scenario "should have" do   
        visit new_user_session_path
        fill_in "Email", with: "typical@gmail.com"
        fill_in "Password", with: "raj@123"
        click_on "Log in"
        sleep(3)
        click_button "Sign out"
        xpath = find(:xpath,"/html[1]/body[1]/p[1]")
        within xpath do
            expect(page).to have_content("Signed out successfully.")
        end
        sleep(2)
    end
end
