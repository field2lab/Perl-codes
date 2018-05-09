#!/usr/bin/perl

use strict;    # always...
use Bio::SeqIO;

my $bigfasta = $ARGV[0];
print $bigfasta."\n";
my $seqin = Bio::SeqIO->new(-file => $bigfasta, -format=>"fasta");

while (my $inseq = $seqin->next_seq) {
        my $id = join ' ', (split /\s+/, $inseq->desc)[0..28];
        my $outfile = "$id.fasta";
		print "Processing $id.fasta\n";
        my $seqout = Bio::SeqIO->new(-file=>">$outfile", -format=>"fasta");
        $seqout->write_seq($inseq);

}
