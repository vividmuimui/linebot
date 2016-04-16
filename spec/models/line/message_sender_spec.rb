require 'rails_helper'

RSpec.describe Line::MessageSender, type: :model do
  before do
    expect(RestClient).to receive(:post)
  end
  subject { Line::MessageSender.send_text_message(users: 1, text: "dummy") }
  specify do
    expect { subject }.not_to raise_error
  end
end
