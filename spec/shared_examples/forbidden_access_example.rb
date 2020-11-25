shared_examples "forbidden access" do
    it "return error messages" do
        expect(body_json['errors']['message']).to eq "Forbidden access" 
    end

    it "return forbidden status" do
        expect(response).to have_http_status(:forbidden) 
    end
end