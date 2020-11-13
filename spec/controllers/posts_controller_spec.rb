require 'rails_helper'

RSpec.describe PostsController do
  let(:post_with_user) { FactoryBot.create(:post) }
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'assigns @posts' do
      get :index
      expect(assigns(:posts)).to eq([post_with_user])
    end

    it 'assigns a new post' do
      get :index
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'POST #create' do
    context 'authenticated user' do
      before(:each) do
        log_in user
      end

      it 'creates a new post with valid params' do
        post_params = FactoryBot.attributes_for(:post)
        expect {
          post :create, params: { post: post_params }
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the root_path' do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to redirect_to(root_path)
      end

      it 'not creates a new post with missing params' do
        expect {
          post :create, params: { post: {} }
        }.to raise_error(ActionController::ParameterMissing)
      end

      it 'return flash message if value of post not valid' do
        post :create, params: { post: { 'body': '' } }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to be_present
      end
    end

    context 'not authenticated user' do
      it 'not creates a new post with valid params' do
        post_params = FactoryBot.attributes_for(:post)
        expect {
          post :create, params: { post: post_params }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'that is the creator of the post' do
      before(:each) do
        log_in post_with_user.user
      end

      it 'destroys the requested post' do
        expect {
          delete :destroy, params: { id: post_with_user.to_param }
        }.to change(Post, :count).by(-1)
      end

      it 'redirects to the root_path' do
        delete :destroy, params: { id: post_with_user.to_param }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context 'that is not the creator of the post' do
    before(:each) do
      log_in user
    end

    it 'raises an authorization error' do
      expect {
        delete :destroy, params: { id: post_with_user.to_param }
      }.to raise_error(CanCan::AccessDenied)
    end
  end

  context 'not authenticated user' do
    it 'raises an authorization error' do
      expect {
        delete :destroy, params: { id: post_with_user.to_param }
      }.to raise_error(CanCan::AccessDenied)
    end
  end
end
