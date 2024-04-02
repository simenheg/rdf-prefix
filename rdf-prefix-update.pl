#!perl -w

# Get prefixes from prefix.cc and format as elisp variable rdf-prefix-alist
# TODO: reimplement as elisp function rdf-prefix-update

use LWP::Simple;
my $url = "https://prefix.cc/popular/all.file.txt";
my $prefixes = get($url);
die "Couldn't GET $url\n" unless $prefixes;

my %prefix;
for (split /\n/,$prefixes) {
  my ($k,$v) = split/\t/;
  $prefix{$k} = $v;
};

binmode (STDOUT, ":encoding(UTF-8)");
print "(defvar rdf-prefix-alist\n";
my $n = 0;
for (sort keys %prefix) {
  print $n++ == 0 ? "  '((" : "\n    (";
  print qq{"$_" . "$prefix{$_}")}
};
print "))\n\n";
