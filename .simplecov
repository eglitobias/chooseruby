# frozen_string_literal: true

# Configuration only; `SimpleCov.start` lives in config/boot.rb and test_helper.rb.
SimpleCov.load_profile "rails"

# Rails runs tests in forked workers; track them too.
SimpleCov.merge_subprocesses true

# Minimums only make sense for a full-suite run: a subset, and `test:system`
# on its own, can never reach them. Set SKIP_COVERAGE_CHECK=1 for a subset.
subset = ARGV.grep(/\Atest:/).any?
enforce = ENV["SKIP_COVERAGE_CHECK"].to_s.empty? && !subset

# Ratchet: raise these as coverage grows. Target is 100 (issue #44).
SimpleCov.coverage :line do
  minimum 76 if enforce
end

SimpleCov.coverage :branch do
  ignore :eval_generated
  minimum 62 if enforce
end
