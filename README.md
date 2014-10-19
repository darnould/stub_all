stub_all
========

An abominable experiment in forcing all required dependencies to be stubbed - without dependency injection.

See `sut_spec.rb` as an entrypoint into what's going on here.

I wonder if a technique like this would allow us to ensure that our unit tests
are fully isolated, without the cognitive overhead of otherwise unnecessary
levels of indirection, i.e. dependency injection.

Maybe I'll package this as a Gem.  But this code is probably executing too many
Ruby war-crimes to deserve that.

## Explanation

Any global constants that come from `require` (which `Kernel.stub_all`
defined here overrides) raise exceptions on method calls.  This forces explicit
stubbing (e.g. `allow`/`expect` in RSpec), and prevents accidental use of real
dependencies outside of the unit being tested - without forcing dependency
injection.

I've yet to see how much this would actually break, in real practice.  Don't do
anything silly like actually using this in production!
