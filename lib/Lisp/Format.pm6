unit module Lisp::Format;

multi sub format(Str:D $format, *@args) returns Str:D is export {
    my @format = $format.comb;
    my @res;
    loop (my $i = 0; $i < ^@format; $i++) {
	given @format[$i] {
	    when '~' {
		$i++;
		$_ = @format[$i];
		my @flag;
		until $_ (elem) ['a', 'p', '~', '%'] or $i == ^@format {
		    @flag.push: $_;
		    $i++;
		}
		@flag.push: $_;
		@res.push: parse-flag @flag, @args;
	    }
	    
	    default {
		@res.push: $_;
	    }
	}
    }
    return [~] @res;
}

sub parse-flag(@flag, @args) returns Str:D {
    for @flag {

	when 'a' {
	    return @args.shift.gist
	}

	when 'p' {
	    return @args.shift.perl
	}

	when '~' {
	    return "~"
	}

	when '%' {
	    return "\n"
	}

	default {
	    fail do { if $_ { "Can't handle flag ~$_" } else { "Trailing '~' in format string" } };
	}
    }
}
