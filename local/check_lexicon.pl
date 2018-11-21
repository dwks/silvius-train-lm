#!/usr/bin/perl

my @words = ();
open(CORPUS, "corpus.txt") or die "No corpus.txt present!";
while(my $word = <CORPUS>) {
    chomp $word;
    push @words, $word;
}

# check for all words
my %found = ();
while(<>) {
    next unless /^(\S+)/;
    for my $w (@words) {
        $found{$w} = 1 if($1 eq $w);
    }
}

my @problems = ();
for my $w (@words) {
    if(!defined($found{$w})) {
        print "Word not in lexicon: [$w]\n";
        push @problems, $w;
    }
}

if(scalar(@problems) > 0) {
    print "ERROR: The following words are not in the lexicon: @problems\n";
    exit 1;
}

exit 0;
