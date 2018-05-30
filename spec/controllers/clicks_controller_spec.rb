require 'rails_helper'

RSpec.describe ClicksController, type: :controller do
  let(:link) { Link.create! url: 'http://example.com' }

  context 'with correct params' do
    describe 'GET #index' do
      it 'redirects to saved link' do
        get :index, params: { token: link.id.to_s(36) }
        expect(response).to redirect_to('http://example.com')
      end
    end
  end

  context 'with incorrect params' do
    describe 'GET #index' do
      render_views

      it 'shows error page' do
        get :index, params: { token: 'wrong_token' }
        expect(response.body).to match(/Sorry, but this link doesn't exist/)
      end
    end
  end
end
