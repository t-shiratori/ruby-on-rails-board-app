require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe 'Get #new' do
        # このコントローラーのnewアクションにgetのhttpメソッドでアクセスすることを擬似的に行なっている
        # getのリクエスト結果がresponse変数に格納される
        before { get :new }
        it 'レスポンスコードが200であること' do
            expect(response).to have_http_status(:ok)
        end

        it 'newテンプレートをレンダリングすること' do
            expect(response).to render_template :new
        end

        it '新しいuserオブジェクトがビューに渡されること' do
            expect(assigns(:user)).to be_a_new User
        end

    end

end
