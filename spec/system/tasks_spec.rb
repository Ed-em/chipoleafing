require 'rails_helper'
RSpec.describe "Tasks management function", type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session_email', with:'user1@example.com'
    fill_in 'session_password', with:'password'
    click_button 'Login'
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
    FactoryBot.create(:third_task, user: @user)
    visit tasks_path
  end

  describe 'new feautures' do
    context 'case was the task to create a new task' do
      it 'should display the new task created' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        fill_in "Deadline", with: '002020-11-24 11:00 PM'
        select 'started'
        select 'low'
        click_button 'Submit'
        expect(page).to have_content 'title test'
        expect(page).to have_content 'content test'
      end
    end
  end

  describe 'list function' do
    context 'to transition to the list screen' do
      it 'already created tasks should be displayed' do
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test2'
        expect(page).to have_content 'sample3'
      end
    end
  end

  describe 'detailed display function' do
    context 'to transition to any task detail screen' do
      it 'contents of relevant task should be displayed' do
        visit new_task_path
        fill_in "Task Name", with: 'title test4'
        fill_in "Task Details", with: 'content test'
        fill_in "Deadline", with: '002020-11-24 11:00 PM'
        select 'started'
        select 'low'
        click_button 'Submit'
        expect(page).to have_content 'title test4'
      end
    end
  end

  describe 'created at test' do
    context 'When you click the  Sort by creation button in the task list' do
      it 'list tasks sorted in descending order of creation date' do
        visit tasks_path
        click_on "Sort by creation"
        assert Task.all.order('created_at desc')
      end
    end
  end

  describe 'created at test' do
    context 'When you click the Sort by duedate button in the task list' do
      it 'list tasks sorted in descending order of deadline' do
        visit tasks_path
        click_on "Sort by duedate"
        assert Task.all.order('duedate desc')
      end
    end
  end

  describe 'search function' do
    context 'If you do a fuzzy search for the title with the scope method' do
      it "Narrows down tasks that include search keywords with title" do
        visit tasks_path
        fill_in "title keyword", with: "sample"
        click_button "search"
        expect(page).to have_content 'sample'
      end
    end

    context 'When a status search is performed with the scope method' do
      it "Narrows down tasks that exactly match with status" do
        visit tasks_path
        select "pending"
        click_button "search"
        expect(page).to have_content 'pending'
      end
    end

    context 'If  you  do a fuzzy search and status search for the title with the scope method' do
      it "Narrow down tasks that include search keywords in the title and exactly match the status" do
        visit tasks_path
        fill_in "title keyword", with: "sample3"
        select "pending"
        click_button "search"
        expect(page).to have_content 'pending'
        expect(page).to have_content 'sample3'
      end
    end
  end

end
