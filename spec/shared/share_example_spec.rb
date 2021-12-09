RSpec.shared_examples "share presence attribute" do |attributes|
  attributes.each do |attr|
    it { is_expected.to validate_presence_of attr }
  end
end
