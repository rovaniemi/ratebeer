module Helpers

  def sign_in(credentials)
    visit singin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end
end
