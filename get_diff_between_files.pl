#!/usr/bin/perl
use strict;
use warnings;

use constant FILE_RESULT => 'diff_file.txt';

my $file1 = $ARGV[0];
my $file2 = $ARGV[1];

if (!defined($file1) || !defined($file2)) {
	print("
USAGE:
	$0 [file-one] [file2]\n\n
");

	exit(1);
}

my @file1_content = get_file_content($file1);
my @file2_content = get_file_content($file2);

write_diff(\@file1_content, \@file2_content);

print('Result file - ' . FILE_RESULT . " is ready for check!\n");

sub write_diff {
	my ($file1_content, $file2_content) = @_;

	open(my $FH, '>', FILE_RESULT) or die('Unable to open file for write' . FILE_RESULT);
	foreach my $file2_line (@{$file2_content}) {
		if (!grep(/^$file2_line$/, @file1_content)) {
				print $FH "$file2_line\n";
		}
	}
	close($FH);
}


sub get_file_content {
	my $file = shift;

	my @file_content;
	my $file_line;

	open(my $FH, '<', $file) or die("Missing or unable to read file - $file!\n");
	while ($file_line = <$FH>) {
		chomp($file_line);
		push(@file_content, $file_line);
	}
	close($FH);

	return @file_content;
}
