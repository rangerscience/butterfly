require 'pry'
Dir[File.join("./lib", "**/*.rb")].each do |f|
  require f
end

module PrintHex
  def to_hex_s
    "0x" + to_s(16).upcase.rjust(6, '0')
  end
end

Integer.include PrintHex

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.order = :random
  config.example_status_persistence_file_path = "tmp/rspec_state.txt"
  config.disable_monkey_patching!
  config.expose_dsl_globally = true
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  # CLI --seed option
  Kernel.srand config.seed

=begin
  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10
=end
end
