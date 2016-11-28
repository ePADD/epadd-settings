#!/usr/bin/perl -w
use experimental 'smartmatch';

print "$ARGV[0]\n";
open($I, "<$ARGV[0].dat") or die "cannot open <$ARGV[0].dat: $!";
open($O, ">$ARGV[0]spacesep.txt") or die "cannot open >$ARGV[0]spacesep.txt : $!";
my $prev_tag = "";
@tags = ('PER','LOC','ORG','MISC');
while(!eof($I)){
    defined( $line = <$I> ) or die "readline failed: $!";
    
    chomp($line);
    @F=split("\t", $line);
    if(length($line)==0 || $#F == -1){
	print $O "\n";
	$prev_tag = "";
	next;
    }
	
    $tag = $F[$#F];
    if($tag ~~ @tags){
	if($prev_tag eq $tag){
	    $tag = "I-".$tag;
	}
	else{
	    $tag = "B-".$tag;
	}
    }	  
    $prev_tag = $F[$#F];
    print $O $F[0];
    map {print $O " $_"} @F[1..$#F-1];
    print $O " $tag\n";
}
close $O;
close $I;
