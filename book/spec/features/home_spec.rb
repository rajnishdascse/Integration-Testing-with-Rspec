require 'rails_helper'

RSpec.describe "Flow of home page", type: :feature do
    scenario "should have" do
        visit "/"
        xpath = find(:xpath, "/html[1]/body[1]/h1[1]")
        within xpath do
            expect(page).to have_content("Hi there, welcome to the BookStore")
        end
        expect(page).to have_button("Sign in")
        expect(page).to have_button("Sign up")
        sleep(2)
    end

    scenario "to the sign up page" do
        visit "/"
        click_button "Sign up"
        expect(page).to have_button("Sign up")
        xpath = find(:xpath, "/html[1]/body[1]/h2[1]")
        expect(page).to have_field("Email")
        expect(page).to have_field("First name")
        expect(page).to have_field("Last name")
        expect(page).to have_field("Password")
        expect(page).to have_field("Password confirmation")
        within xpath do
            expect(page).to have_content("Sign up")
        end
    end

     scenario "to the sign in page" do
        visit "/"
        click_button "Sign in"
        expect(page).to have_button("Log in")
        xpath = find(:xpath, "/html[1]/body[1]/h2[1]")
        within xpath do
            expect(page).to have_content("Log in")
        end
        expect(page).to have_field("Email")
        expect(page).to have_field("Password")
    end
end