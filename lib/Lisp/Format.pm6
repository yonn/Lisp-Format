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
	    $input = False;
	    
	    when '~' {
		@res.push: '~';
	    }

	    when 'a' {
		@res.push: @args.shift.gist;
	    }
	    
	    default {
		fail "Can't handle flag ~$_";
	    }
	}
    }
    if $input {
	fail "Trailing '~' in format string";
    }
    return [~] @res;
}
