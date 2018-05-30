require 'rails_helper'

RSpec.shared_examples 'success' do
  it 'returns http success' do
    expect(response).to have_http_status(:success)
  end

  it 'renders "show" template' do
    expect(response).to render_template('show')
  end

  it 'assigns an new instance of link' do
    expect(assigns(:link).new_record?).to eq(true)
  end
end

RSpec.shared_examples 'empty_link' do
  it 'assigns an empty instance of link' do
    expect(assigns(:link).errors.size).to eq(0)
    expect(assigns(:link).url).to be_nil
    expect(assigns(:link).token).to be_nil
  end
end

RSpec.describe LinksController, type: :controller do
  describe 'GET #show' do
    before(:each) { get :show }

    include_examples 'success'
    include_examples 'empty_link'
  end

  describe 'POST #create' do
    context 'with correct params' do
      before(:each) do
        post :create, params: { link: { url: 'http://example.com' } }
      end

      include_examples 'success'
      include_examples 'empty_link'

      it 'assigns a result' do
        result = assigns(:result)
        expect(result).to be_instance_of(Link)
        expect(result.url).to eq('http://example.com')
        expect(result.token).to eq(result.id.to_s(36))
      end
    end

    context 'with incorrect params' do
      before(:each) do
        post :create, params: { link: { url: 'wrong_url' } }
      end

      include_examples 'success'

      it 'assigns an invalid instance of link' do
        expect(assigns(:link).errors.size).to eq(1)
      end
    end
  end
end
