## Instructions for LLMs

1. Make sure you load the file `docs/llms.md` and read it all. Never skip reading that file for any task.

## Test coverage

SimpleCov measures line and branch coverage on every `bin/rails test` run and fails
the run when coverage drops below the minimums in `.simplecov`. The target is 100%
line and branch coverage; the minimums are a ratchet on the way there, so raise them
whenever coverage rises. Never lower them.

When a line or branch is uncovered, decide which case it is before changing anything:

- **The code does too much.** No test requires that behaviour. Simplify the implementation.
- **A test is missing.** The behaviour is intentional but unobserved. Add a test.

If you are unsure which, ask.

## Before finishing work

Run `bin/ci` and make sure it reports no issues.
