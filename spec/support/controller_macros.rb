module ControllerMacros
  def contributor_login
    request.env['omniauth.auth'] = mock_auth_hash 
    @contributor = Fabricate(:contributor, nickname: 'mock_name', provider: 'github', uid: '1337', token: 'mock_token') 
    session[:contributor_id] = @contributor.id
  end
end


