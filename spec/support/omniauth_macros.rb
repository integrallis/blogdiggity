module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.mock_auth[:github] = {
      'provider' => 'github',
      'uid' => '1337',
      'credentials' => {
        'token' => 'mock_token' 
      }, 
      'info' => {
        'nickname' => 'mock_name'
      }
    }      
  end
end
