require 'rails_helper'

RSpec.describe Snippet, type: :model do
  describe "validations" do
    it "doesn't allow creating a snippet with no title" do
      s = Snippet.new( body: "some body", language_id: 1)
      snippet_valid = s.valid?
      expect(snippet_valid).to eq(false)
    end

    it "doesn't allow creating a snippet with no body" do
      s = Snippet.new( title: "some title", language_id: 1)
      snippet_valid = s.valid?
      expect(snippet_valid).to eq(false)
    end

    it "doesn't allow creating a snippet with no language_id" do
      s = Snippet.new( title: "some title", body: "some body")
      snippet_valid = s.valid?
      expect(snippet_valid).to eq(false)
    end

    it "doesn't allow creating a snippet with existing combination of title, body, and language_id" do
      Snippet.create(title: "some title", body:"some body", language_id:1)

      s = Snippet.new( title: "some title", body: "some body", language_id:1)
      snippet_valid = s.valid?
      expect(snippet_valid).to eq(false)
    end



  end
end
