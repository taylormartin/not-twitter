require 'rails_helper'

feature 'Tweeting' do
  it 'lets users post a tweet' do
    user = create :user
    login user
    visit root_path
    fill_in "Tweet", with: "Omniscient Bob"
    click_on "Submit"

    # v- could be more specific, should mention flash
    expect( page ).to have_content "Successful"
    # v- could specify content of tweet, at top of list, etc.
    expect( page ).to have_content "Omniscient Bob"

    # v- mixing concerns?
    #expect( Tweet.count ).to eq 1
  end
end
