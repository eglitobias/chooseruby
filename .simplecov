# frozen_string_literal: true

# Configuration only; `SimpleCov.start` lives in test/test_helper.rb.
SimpleCov.load_profile "rails"

# Rails runs tests in forked workers; track them too.
SimpleCov.merge_subprocesses true

# Minimums only make sense for a full-suite run. Set SKIP_COVERAGE_CHECK=1
# when running a subset of the tests.
enforce = ENV["SKIP_COVERAGE_CHECK"].to_s.empty?

# Ratchet: raise these as coverage grows. Target is 100 (issue #44).
SimpleCov.coverage :line do
  minimum 47 if enforce
end

SimpleCov.coverage :branch do
  ignore :eval_generated
  minimum 33 if enforce
end
