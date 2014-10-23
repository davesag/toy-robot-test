# Toy Robot Test

This is my stab at the standard Toy Robot test.

The Specification was emailed to me at 10:50pm on Thursday 24 October and I completed the core
code by midnight.  I then spent half an hour tidying it up and writing this Readme document.

I solemnly declare that I did not copy this code from anyone else, and that it's all my own originl  work.

If you have been asked to do this test I urge you to not to copy my, or anyone else's work.

## Approach

I selected `Ruby` (version 2.1.3 is specified) as the language to write this in,
which is fair given I am pitching for a `Ruby` focussed job.

I started by converting the spec into a simple suite of `rspec` tests and then
adding code to fulfil those tests.

I then enhanced the tests with unhappy-path tests and enhanced the code to
cater for those situations in a predicatble way.

The spec itself is silent on how to deal with erronious input.

## To run

The code itself requires no additional libraries so you can just run

    ruby toy_robot.rb
    
## To test

To run the rspec tests ensure you have installed `rspec` and `simplecov` by running

    bundle

then

    rspec

There are 15 tests giving an over 90% code coverage of the whole project.

## License

Even though you are not meant to copy this if doing a test; I'm not at all precious about it, and hey, it's not my test, just my stab at it.

The MIT License (MIT)

Copyright (c) 2014 Dave Sag

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

