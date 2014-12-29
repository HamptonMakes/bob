bob
===

A simple Haml/Sass builder for multi-platform HTML5 apps by Hampton Catlin (@hcatlin)

Philosophies!
-------------

  * Simple HTML5 apps are good to build in Haml and Sass
  * Phonegap is WAYYYYY too complicated for most of the things I need
  * "Static" site generators only want to target one platform
  * Multi-platform HTML5 apps are awesomesauce
  * Building should be simple and minimal
    * What ends up in the platform build should be just what's needed
  * Every app loads from index.html/haml
  * Each platform might have some custom configuration

Installation
------------

First, get Ruby and Bundler installed. If you are on OS X, that 
just means, run

    gem install bundler

If you are linux, then you are a big enough nerd to figure it
out by yourself.

    git clone https://github.com/hcatlin/bob your_app_name
    cd your_app_name
    bundle install

Then, you can run "./build" to make sure no errors happen! DONE!

How it works!
-------------

You should spend your time developing in the "src" directory. We have some simple
bootstrapped things there. Everything you run "./build", it will compile
the stuff in the src directory and poop it out into each of the platforms.

Platforms are defined in the 'config.json' file. You can override defaults
there that are currently found defined in 'lib/bob/platform.rb'... which 
kind of stinks now that I think of it.

Easiest way to work is... 

    open platforms/chrome/data/index.html
    guard start

Guard will run "./build" whenever a file changes. Pretty cool, eh!
Now get into that src/ folder and start building some shit! 

Current issues
--------------

  * Building is too slow and requires a full rebuild of everything
  * Had to remove "iPhone" platform target b/c too much vendor stuff in there
      * Need to think about how to handle heavy frameworks!
  * The 'platform.rb' object is crappy and confused
