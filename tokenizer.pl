#!/usr/bin/perl

## Tokenizer in perl for Indic texts
## Pads all punctuations with spaces before and after, including daMDa and double daMDa in Hindi
## 01 December 2019
## Ram Anirudh
## Saved backup as tokenizer1.0.pl

######################################################################
## 21 December 2019
## Ver-1.1
## Use command line argument and tokenize

## 20 December - started working on options - GetOpt::Long
## 21 December - working version with GetOpt::Long - upgraded and saved as version 1.1

#####Method of Execution#####

#$perl tokenizer.pl --input foo --output bar

# where foo and bar are input and output filenames respectively
# input is a required field; output is optional: default file generated is a file with extension ".tok"

######################################################################

use Getopt::Long;

#my $input = $ARGV[0];
my $input = "";
my $output = "";
my $help;
GetOptions("input=s"=>\$input,"output=s"=>\$output,"help"=>\$help);
#print "$input\t$output\n";

## Displays the message how to use the program if --help option is given
if($help){
    print "Usage: perl tokenizer.pl --input <foo.txt> --output <bar.txt>\n\n";
    print "  Input is a required field\n";
    print "  Output is optional: if not specified, will generate output with a \n  default extension of \".tok\" appended to input\n";
    exit;
}

## This should follow help since, if help is given, this may not be required, even otherwise, displaying help with other options is not bad...
if(!$input){
    print "Please provide input file with option --input \n";
    exit;
}

if(!$output){
    $output = "$input.tok";
}

#GetOptions("output=s"=>\$output);

#Call to function; argument - filename; output written to a file named filename.tok

tokenizer($input);

######################################################################

sub tokenizer{
    my $file = $_[0];
    open my $F,"<:encoding(UTF-8)","$file" or die $!;
    open my $O,">:encoding(UTF-8)","$output" or die $!;

    print "Tokenizing $file... please wait\n";
    while(my $line = <$F>){

#	chomp($line);
	
	$line =~ s/([\'!"#$%&\'()*+,-.\/:;<=>?@\[\\\]^_`\{|\}~\'\x{0964}\x{0965}])/ \1 /g;
	$line =~ s/\t+| +/ /g;
	
	#	if($line =~ /([\'!"#$%&\'()*+,-.\/:;<=>?@\[\\\]^_`{|}~\'\u0964\u0965])/){
	#	    print 	    
	#	}

	print $O "$line";
    }
    close($F);
    close($O);
}
