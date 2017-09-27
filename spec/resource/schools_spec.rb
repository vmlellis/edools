require 'spec_helper'

RSpec.describe Edools::Resource::Schools do
  describe '#all' do
    it 'call get to /api/schools'
    it 'return schools as array of Object::School'
  end

  describe '#create' do
    it 'call post to /api/schools/wizard'
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
