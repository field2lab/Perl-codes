#Copyright (c) 2010 LUQMAN HAKIM BIN ABDUL HADI (csilhah@nus.edu.sg)
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files 
#(the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, 
#merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
#OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
#IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use File::Basename;

my @files = glob("*.*");

my ($header,$sequence, $sequence_length, $sequence_quality);


foreach my $file (@files) {
                my ($id, $suffix) = $file =~ /(.*)(\..*)/;
                my $out = join (".",$id,,"R1","fastq");
		open my $IN, "<", "$file" or die "Can't open $file\n";
                open my $OUT, ">", "$out" or die "Can't load $out file\n";
                
while(<$IN>) {
        chomp $_;
        if ($_ =~ /^>(.+)/) {
                if($header ne "") {
                        print "\@".$header."\n";
                        print $sequence."\n";
                        print "+"."\n";
                        print $sequence_quality."\n";
                }
                $header = $1;
		$sequence = "";
		$sequence_length = "";
		$sequence_quality = "";
        }
	else { 
		$sequence .= $_;
		$sequence_length = length($_); 
		for(my $i=0; $i<$sequence_length; $i++) {$sequence_quality .= "I"} 
	}
}
close $IN;
print $OUT "\@$header\n$sequence\n+\n$sequence_quality\n";
close $OUT;
}
