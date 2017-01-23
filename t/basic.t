use v6;
use Test;

use Lisp::Format;

plan 4;

is format(''), "";
is format('Hello'), 'Hello';
is format('~~'), '~';

dies-ok { format('~!') };

done-testing;
