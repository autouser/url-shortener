require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'is valid' do
    it 'with correct arguments' do
      link = Link.create id: 100, url: 'http://example.com'
      expect(link).to be_valid
      expect(link.url).to eq('http://example.com')
      expect(link.token).to eq(link.id.to_s(36))
    end
  end

  context 'is invalid' do
    it 'with incorrect URL' do
      link = Link.create id: 100, url: 'wrong_url'
      expect(link).to be_invalid

      messages = link.errors.full_messages
      expect(messages.size).to eq(1)
      expect(messages).to include('URL is invalid')
    end

    it 'with URL longer than 255 chars' do
      link = Link.create id: 100, url: ('x' * 256)
      expect(link).to be_invalid

      messages = link.errors.full_messages
      expect(messages.size).to eq(2)
      expect(messages).to include(
        'URL is invalid',
        'URL is too long (maximum is 255 characters)'
      )
    end
  end
end
