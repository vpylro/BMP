#!usr/bin/perl

##Leandro Nascimento Lemos
##Victor Pylro
##Melline Fontes
##25-04-2014 1.0
#QiimeToUparse
#Contact: Victor Pylro: victor.pylro@gmail.com, Leandro Lemos: lemosbioinfo@gmail.com or Luiz Roesch: luiz.roesch@gmail.com
#How to use this script?
#perl bmp-Qiime2Uparse.pl -i something.fasta -o something.uparse.fasta

use strict;
use warnings;
use Getopt::Std;
use Getopt::Long;

my $inputfile;
my $outputfile;


Getopt::Long::Configure ('bundling');
GetOptions ('i|input_file=s' => \$inputfile,
	    'o|output_file_prefix=s' => \$outputfile);

if(!defined($inputfile)) {
    die ("Usage: bmp-Qiime2Uparse.pl -i <input file> -o <output file>\n");
}

if(!defined($outputfile)) {
    die ("Usage: bmp-Qiime2Uparse.pl -i <input file> -o <output file>\n");
}


$/ = ">"; 

open(FASTA, $inputfile) or die "Cannot open the fasta file...";
my $f = $inputfile;
$f =~ s/\..*$//g;
open(SAIDA, ">" . $outputfile) or die "!";
$_ = <FASTA>;



while(my $inputfile = <FASTA>){
    chomp($inputfile);
    my @seq = split("\n", $inputfile); 
    my $header = $seq[0];
    my $sequence;
    foreach my $i(1..$#seq){
	$sequence .= $seq[$i];
    }
    (my $nome, my $campo02, my $campo3, my $campo4, my $barcode01, my $barcode02, my$campo6) = split(" ", $header);
    my $novo_nome = $nome;
    
    $novo_nome =~ s/\_.*$//g;
    
    print SAIDA ">$nome;barcodelabel=$novo_nome\n$sequence\n";
    
}
close(SAIDA);
close(FASTA);
