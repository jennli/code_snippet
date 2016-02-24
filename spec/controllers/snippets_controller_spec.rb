require 'rails_helper'

RSpec.describe SnippetsController, type: :controller do

  let(:user){FactoryGirl.create(:user)}
  let(:language){FactoryGirl.create(:language)}
  let(:snippet){FactoryGirl.create(:snippet, {user: user, language:language})}
  let(:snippet_1){FactoryGirl.create(:snippet)}

  describe "#new" do
    subject {get :new}
    # it "renders the new template" do
    #   expect(subject).to render_template(:new)
    # end

    context "user signed in" do
      before {request.session[:user_id] = user.id}
      it {is_expected.to render_template(:new)}
    end

    context "user not signed in" do
      it {is_expected.to redirect_to(new_session_path)}
    end
  end

  describe "#create" do
    context "with signed in user" do
      before {request.session[:user_id] = user.id}
      context "valid request" do
        subject {post :create, snippet: FactoryGirl.attributes_for(:snippet).merge({language_id: language.id})}
        it "creates a record in the database" do
          # count_before = Snippet.count
          # subject
          # count_after = Snippet.count
          # expect(count_after - count_before).to eq(1)
          expect {subject}.to change(Snippet, :count).by(1)
        end

        it {is_expected.to redirect_to(Snippet.last)}

        it "should show a flash notice" do
          subject
          expect(flash[:notice]).to be
        end
      end

      context "no valid request" do
        # this is creating a snippet with no language id
        subject {post :create, snippet: FactoryGirl.attributes_for(:snippet)}
        it "doesn't create a record in the database" do
          expect {subject}.to change(Snippet, :count).by(0)
        end

        it{is_expected.to render_template(:new)}

        it "should show a flash alert" do
          subject
          expect(flash[:alert]).to be
        end
      end
    end

    context "with no signed in user" do
      subject {post :create, snippet: FactoryGirl.attributes_for(:snippet).merge({language_id: language.id})}

      it "should not create a record" do
        expect {subject}.to change(Snippet, :count).by(0)
      end

      it "shouls show a flash alert" do
        subject
        expect(flash[:alert]).to be
      end

    end
  end

  describe "#edit" do
    before {request.session[:user_id] = user.id}
    context "user is authorized to edit" do
      subject {get :edit, id: snippet.id}
      it {is_expected.to render_template(:edit)}
    end

    context "user is not authorized to edit" do
      subject {get :edit, id: snippet_1.id}
      it {is_expected.to redirect_to(snippet_1)}

      it "shows an alert" do
        subject
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#update" do
    context "with valid signed in user" do
      before {request.session[:user_id] = user.id}

      context "update with valid params" do
        subject {patch :update, id: snippet.id, snippet: {title:"new title", language_id:1}}

        it "should update snippet's title" do
          #   subject
          #   expect(snippet.reload.title).to eq("new title")
          expect{subject; snippet.reload;}.to change(snippet, :title)
        end

        it "should update snippet's language kind" do
          expect{subject; snippet.reload;}.to change(snippet, :language)
        end

        it {is_expected.to redirect_to(snippet)}

        it "should show a flash notice" do
          subject
          expect(flash[:notice]).to be
        end
      end

      context "update with invalid params" do
        # update using attribute values of snippet_1,
        # which should violate snippet validation of unique title, body, language combination
        subject {patch :update, id: snippet.id, snippet: {title:snippet_1.title, body: snippet_1.body, language_id: snippet_1.language_id}}

        it "should not update snippet's title" do
          expect{subject; snippet.reload;}.to_not change(snippet, :title)
        end

        it "should not update snippet's language kind" do
          expect{subject; snippet.reload;}.to_not change(snippet, :language)
        end

        it {is_expected.to render_template(:edit)}

        it "should show a flash alert" do
          subject
          expect(flash[:alert]).to be
        end
      end

    end

    context "with invalid signed in user" do
      before {request.session[:user_id] = user.id}
      subject{patch :update, id: snippet_1.id, snippet: {title:"some valid title"}}

      it "should not update snippet's title" do
        expect{subject; snippet_1.reload;}.to_not change(snippet_1, :title)
      end

      it{is_expected.to redirect_to(snippet_1)}

      it "should show a flash alert" do
        subject
        expect(flash[:alert]).to be
      end
    end

  end
end
