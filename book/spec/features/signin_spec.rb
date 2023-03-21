require 'rails_helper'

RSpec.describe 'Sign in to site', type: :feature do
    scenario 'with valid inputs' do
        visit "/"
        click_button 'Sign in'
        fill_in "Email", with: "typical@gmail.com"
        fill_in "Password", with: "raj@123"
        sleep(2)
        click_on 'Log in'
        expect(page).to have_button("Sign out")
    end

    scenario 'with invalid inputs' do
        visit "/"
        click_button 'Sign in'
        fill_in "Email", with: "bontonniom@gmail.com"
        fill_in "Password", with: "raj@123"
        sleep(2)
        click_on 'Log in'
        expect(page).to have_content("Invalid Email or password.")
        sleep(2)
    end

    scenario 'with blank inputs' do
        visit "/"
        click_button 'Sign in'
        fill_in "Email", with: ""
        fill_in "Password", with: ""
        sleep(2)
        click_on 'Log in'
        xpath = find(:xpath,"/html[1]/body[1]/p[2]")
        within xpath do
            expect(page).to have_content("Invalid Email or password.")
        end
        sleep(2)
    end


    scenario "going from login page" do
        visit new_user_registration_path
        click_on "Log in"
        sleep(3)
        xpath = find(:xpath, "/html[1]/body[1]/h2[1]")
        expect(page).to have_field("Email")
        expect(page).to have_field("Password")
        within xpath do
            expect(page).to have_content("Log in")
        end
        expect(page).to have_button("Log in")
    end

end
        