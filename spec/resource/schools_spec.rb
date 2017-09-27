require 'spec_helper'

RSpec.describe Edools::Resource::Schools do
  let(:uri) { 'https://core.myedools.info/' }
  let(:endpoint) { 'api/schools' }
  let(:settings) { Edools.settings }

  # let(:headers) do
  #   {
  #     'Accept' => 'application/vnd.edools.core.v1+json',
  #     'Authorization' => 'Token token="TOKEN"',
  #     'Expect'=>'',
  #     'User-Agent'=>'Faraday v0.13.1'
  #   }
  # end

  before do
    settings.token = 'TOKEN'
    settings.school_id = 1000
  end

  subject { described_class.new(settings) }

  describe '#all' do
    let(:body) do
      {
        schools: [
          {
            'id' => 940,
            'name' => 'test',
            'subdomain' => 'test-28c2',
            'email' => 'test@test.com',
            'status' => 'trial',
            'created_at' => '2017-09-27T22:09:38.861Z',
            'updated_at' => '2017-09-27T22:09:39.873Z',
            'last_collaborator_sign_in' => '2017-09-27T22:09:40.404Z',
            'students_count' => 0
          }
        ],
        current_page: 1,
        per_page: 10,
        total_pages: 1,
        total_count: 1
      }
    end

    before do
      @stub = stub_request(:get, "#{uri}#{endpoint}")
        .to_return(body: body.to_json)

      @response = subject.all
    end

    it 'call get to /api/schools' do
      expect(@stub).to have_been_requested
    end

    it 'return schools as array of Object::School' do
      expect(@response).to be_a(Hash)
      expect(@response['schools']).to be_a(Array)
      expect(@response['schools'][0]).to be_a(Edools::Object::School)
    end
  end

  describe '#create' do
    let(:body) do
      {
        school: { id: 1000, subdomain: 'test-28c2', name: 'test' },
        library: { id: 940 },
        organization: { id: 934, name: 'test' },
        admin: {
          id: 590808, full_name: 'test', email: 'test@test.com',
          credentials: 'TOKEN', role_id: 12729
        },
        forum: { id: 940 }
      }
    end

    before do
      @stub = stub_request(:post, "#{uri}#{endpoint}/wizard")
        .to_return(body: body.to_json)

      @response = subject.create('test', 'test@test.com', '123456')
    end

    it 'call post to /api/schools/wizard' do
      expect(@stub).to have_been_requested
    end

    it 'return credentials'
    it 'return school_id'
  end

  describe '#get' do
    it 'call get to /api/schools/SETTINGS_SCHOOL_ID'
  end

  describe '#find' do
    it 'call get to /api/schools/SCHOOL_ID'
  end

  describe '#update' do
    it 'call put to /api/schools/SCHOOL_ID'
  end
end
