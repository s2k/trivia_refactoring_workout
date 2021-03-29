# Why this exists

It's a preparation of a Refactoring Workout.
This repo's history start as a copy of @jbrains' https://github.com/jbrains/trivia and updates a few things right away: RSpec and the `expect` notation, as well as using [Guard](https://github.com/guard/guard) to provide feedback as immediate as possible: when saving a file.


# Test Frameworks

This repo has configuration and example files for both RSpec and minitest. The
RSpec files are in `/spec` and the minitest files are in `/test`.

First install both of the gems using Bundler (don't worry, you'll only be
using one at a time):

    bundle install

You can run the RSpec tests using:

    rake spec

And the minitest test using:

    rake minitest

Please modify any and all of these files to suit your preferences; these are
simply meant as a starting point!
