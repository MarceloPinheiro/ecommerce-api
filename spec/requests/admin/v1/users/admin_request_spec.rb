require 'rails_helper'

RSpec.describe "Admin::V1::user as :admin", type: :request do
    let(:user_l) { create(:user) }
    context "GET /users" do
        let(:url) { "/admin/v1/users" }
        let!(:users) { create_list(:user, 5) }
        
        it "returns all users" do
            get url, headers: auth_header(user_l)
            expect(body_json['users']).to include *users.as_json(only: %i(id name profile))
        end

        it "returns success status" do
            get url, headers: auth_header(user_l)
            expect(response).to have_http_status(:ok)
        end
    end

    context "POST /users" do
        let(:url) { "/admin/v1/users" }
    
        context "with valid params" do
            let(:user_params) { { user: attributes_for(:user) }.to_json }

            it 'adds a new user' do
                expect do
                post url, headers: auth_header(user_l), params: user_params
                end.to change(User, :count).by(2)
            end

            it 'returns last added user' do
                post url, headers: auth_header(user_l), params: user_params
                expected_user = User.last.as_json(only: %i(id name profile))
                expect(body_json['user']).to eq expected_user
            end

            it 'returns success status' do
                post url, headers: auth_header(user_l), params: user_params
                expect(response).to have_http_status(:ok)
            end
        end
    
        context "with invalid params" do
            let(:user_invalid_params) do 
                { user: attributes_for(:user, name: nil) }.to_json
            end
            
            it 'does not add a new user' do
                expect do
                    post url, headers: auth_header(user_l), params: user_invalid_params
                end.to change(User, :count).by(1)
            end

            it 'returns error message' do
                post url, headers: auth_header(user_l), params: user_invalid_params
                expect(body_json['errors']['fields']).to have_key("name")
            end

            it 'returns unprocessable_entity status' do
                post url, headers: auth_header(user_l), params: user_invalid_params
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    context "PATCH /users/:id" do
        let(:user) { create(:user) }
        let(:url) { "/admin/v1/users/#{user.id}" }

        context "with valid params" do
            let(:new_name) { 'Name System' }
            let(:new_memory) { 'New Memory' }
            let(:user_params) { { user: { name: new_name, memory: new_memory } }.to_json }

            it 'updates users' do
                patch url, headers: auth_header(user_l), params: user_params
                user.reload
                expect(user.name).to eq new_name
            end

            it 'returns updated user' do
                patch url, headers: auth_header(user_l), params: user_params
                user.reload
                expected_user = user.as_json(only: %i(id name profile))
                expect(body_json['user']).to eq expected_user
            end

            it 'returns success status' do
                patch url, headers: auth_header(user_l), params: user_params
                expect(response).to have_http_status(:ok)
            end
        end
    
        context "with invalid params" do
            let(:user_invalid_params) do 
                { user: attributes_for(:user, name: nil) }.to_json
            end

            it 'does not update user' do
                old_name = user.name
                patch url, headers: auth_header(user_l), params: user_invalid_params
                user.reload
                expect(user.name).to eq old_name
            end

            it 'returns error message' do
                patch url, headers: auth_header(user_l), params: user_invalid_params
                expect(body_json['errors']['fields']).to have_key('name')
            end

            it 'returns unprocessable_entity status' do
                patch url, headers: auth_header(user_l), params: user_invalid_params
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    context "DELETE /users/:id" do
        let!(:user) { create(:user) }
        let(:url) { "/admin/v1/users/#{user.id}" }

        it 'removes user' do
            expect do  
                delete url, headers: auth_header(user_l)
            end.to change(User, :count).by(0)
        end

        it 'returns success status' do
            delete url, headers: auth_header(user_l)
            expect(response).to have_http_status(:no_content)
        end

        it 'does not return any body content' do
            delete url, headers: auth_header(user_l)
            expect(body_json).to_not be_present
        end
    end

end
