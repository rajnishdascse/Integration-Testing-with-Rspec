require 'rails_helper'

RSpec.describe "Signup to the site", type: :feature do
    scenario "with valid inputs" do
        visit "/"
        sleep(2)
        click_button "Sign up"
        fill_in 'Email', with: 'typical@gmail.com'
        fill_in 'First name', with: 'rajnish'
        fill_in 'Last name', with: 'das'
        fill_in 'Password', with: 'raj@123'
        fill_in 'Password confirmation', with: 'raj@123'
        select 'Male', from: 'Gender'  
        sleep(5)
        click_on 'Sign up'
        xpath = find(:xpath, "//h1[normalize-space()='Hello, Rajnish']")
        within xpath do
          expect(page).to have_content("Hello, Rajnish")
        end
        expect(page).to have_button("Sign out")
        expect(page).to have_content("Welcome! You have signed up successfully.\nHello, Rajnish\nWelcome to the BookStore")
        sleep(2)
    end
   
    scenario "with existing emal id" do
      visit "/"
      sleep(2)
      click_button "Sign up"
      fill_in 'Email', with: 'typical-new@gmail.com'
      fill_in 'First name', with: 'rajnish'
      fill_in 'Last name', with: 'das'
      fill_in 'Password', with: 'raj@123'
      fill_in 'Password confirmation', with: 'raj@123'
      select 'Male', from: 'Gender'  
      sleep(2)
      click_on 'Sign up'
      xpath = find(:xpath, "/html[1]/body[1]/form[1]/div[1]/ul[1]/li[1]")
      within xpath do
        expect(page).to have_content("Email has already been taken")
      end
  end
  
    scenario "with invalid inputs" do
        visit "/"
        click_button 'Sign up'
        fill_in "Email", with: ''
        fill_in 'First name', with: 'rajnish'
        fill_in 'Last name', with: 'das'
        fill_in 'Password', with: 'raj@123'
        fill_in 'Password confirmation', with: 'raj@123'
        select 'Male', from: 'Gender'  
        sleep(2)
        click_on 'Sign up'
        # expect(page).to have_button('Sign out')   #---it gonna fail until a successful login
        xpath=find(:xpath,"//h2[normalize-space()='1 error prohibited this user from being saved:']")
        within xpath do
          expect(page).to have_content("error prohibited this user from being saved:")
        end
        sleep(2)
    end
  
    scenario "with blank email id" do
        visit "/"
        click_button 'Sign up'
        fill_in "Email", with: ''
        fill_in 'First name', with: 'rajnish'
        fill_in 'Last name', with: 'das'
        fill_in 'Password', with: 'raj@123'
        fill_in 'Password confirmation', with: 'raj@123'
        select 'Male', from: 'Gender'  
        sleep(2)
        click_on 'Sign up'
        xpath=find(:xpath,"/html[1]/body[1]/form[1]/div[1]/ul[1]/li[1]")
        within xpath do
          expect(page).to have_content("Email can't be blank")
        end
        sleep(2)
    end
  
    scenario "with wrong password confirmation" do
        visit "/"
        click_button 'Sign up'
        fill_in "Email", with: 'dell@gmail.com'
        fill_in 'First name', with: 'dell'
        fill_in 'Last name', with: 'das'
        fill_in 'Password', with: 'raj@123'
        fill_in 'Password confirmation', with: 'raj@12345'
        select 'Male', from: 'Gender'  
        sleep(2)
        click_on 'Sign up'
        xpath=find(:xpath,"/html[1]/body[1]/form[1]/div[1]/ul[1]/li[1]")
        within xpath do
          expect(page).to have_content("Password confirmation doesn't match Password")
        end
        sleep(2)
    end
  
    scenario "with short password" do
        visit "/"
        click_button 'Sign up'
        fill_in "Email", with: 'dell@gmail.com'
        fill_in 'First name', with: 'dell'
        fill_in 'Last name', with: 'das'
        fill_in 'Password', with: 'sass'
        fill_in 'Password confirmation', with: 'sass'
        select 'Prefer not to say', from: 'Gender'  
        sleep(2)
        click_on 'Sign up'
        xpath=find(:xpath,"/html[1]/body[1]/form[1]/div[1]/ul[1]/li[1]")
        within xpath do
          expect(page).to have_content("Password is too short")
        end
        sleep(2)
    end
  
    # scenario "going to login page from signup page" do
    #     visit "/"
    #     click_button "Sign up"
    #     click_on "Log in"
    #     sleep(3)
    #     xpath = find(:xpath, "/html[1]/body[1]/form[1]/div[3]/label[1]")
    #     expect(page).to have_field("Email")
    #     expect(page).to have_field("Password")
    #     within xpath do
    #         expect(page).to have_content("Remember me")
    #     end
    #     expect(page).to have_button("Log in")
    # end
  
    scenario "going from login page" do
        visit new_user_session_path
        click_on "Sign up"
        sleep(2)
        xpath = find(:xpath, "/html[1]/body[1]/h2[1]")
        expect(page).to have_field("Email")
        expect(page).to have_field("First name")
        expect(page).to have_field("Last name")
        expect(page).to have_field("Password")
        expect(page).to have_field("Password confirmation")
        within xpath do
            expect(page).to have_content("Sign up")
        end
        expect(page).to have_button("Sign up")
    end
end

