unit module Lisp::Format;

multi sub format(Str:D $format, *@args) returns Str:D is export {
    my @res;
    my $input = False;
    for $format.comb {
	if not $input {
	    when '~' {
		$input = True;
	    }
	    default {
		@res.push: $_;
	    }
	} else {
	    when '~' {
		@res.push: '~';
	    }
	    default {
		return fail "Couldn't format flag ~$_";
	    }
	}
    }
    return [~] @res;
}
