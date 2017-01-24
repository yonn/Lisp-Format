use v6;
use Test;

use Lisp::Format;

plan 11;

is format(''), "";
is format('Hello'), 'Hello';
is format('~~'), '~';
is format('String', 'arg1', 'arg2'), 'String';

is format('~a', 5040), '5040';
is format('~a', 'String'), 'String';
my class GistExample { method gist { 'Human readable text!' } }
is format('~a', GistExample.new), 'Human readable text!';

is format('Hello, ~a', 'World!'), 'Hello, World!';
is format('~a + ~a = ~a', 1, 2, 3), '1 + 2 = 3';

dies-ok { format('~!') };
dies-ok { format('~') };

done-testing;
