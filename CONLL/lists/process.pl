#!/usr/bin/perl -w
#strip any extension, pipe the arguments through xargs
foreach my $file (@ARGV){
    $name = $file;
    $name=~s/^\.\///;
    open($in,"<",$file) or die "Cannot read: $!";
    open($out,">","ePADD.".$name) or die "Cannot write: $!";
    while ($line=<$in>){
	@f=split(" ",$line);
	if($#f>=1){
		$t=$f[0];
		my $et="";
		if($t eq "LOC"){
		    $et="Place";
		}
		elsif($t eq "PER"){
		    $et="Person";
		}
		elsif($t eq "ORG"){
		    $et="Organisation"
		}
		$mw = join(" ",@f[1..$#f]);
		#print $mw."\n";
		$mw=~s/ /\_/g;
		#print "String: ".$mw."\n";
		print $out $mw." ".$et."\n";
	}
    }
    close $in;
    close $out;
    print "$file --> ePADD.$name\n";
}
