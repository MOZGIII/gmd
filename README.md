gmd
===


What is it?
-----------

gmd is a small command-line utility to easily generate fancy HTML from Markdown.


Installation
------------

    $ [sudo] gem install gmd


Usage
-----

    $ gmd text.md

Will generate HTML from the `text.md` and save it to `text.html`.

    $ gmd text.md -l <layout>

Will generate and save HTML from the `text.md` using specified layout.

Built-in layouts:

  + *default*
  + *github* - something similar to new GitHub style
  + *metal* - something like older GitHub style

Actually, the deafult style is also (a very very old) GitHub style ;)


TeX-based math
--------------

gmd supports TeX formulas!
Just use `$ ... $` for inline math and `$$ ... $$` for display math.

    An inline math here: $e^{i\pi} = -1$. Awesome!

    $$
    \left( \sum_{k=1}^n a_k b_k \right)^{\!\!2} \leq
     \left( \sum_{k=1}^n a_k^2 \right) \left( \sum_{k=1}^n b_k^2 \right)
    $$
