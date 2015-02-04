#!usr/bin/perl

##Leandro Nascimento Lemos
##Victor Pylro
#Melline Fontes Noronha
##25-04-2014 1.0
##Atualizado em: 15-01-2015
#Demultiplex
#Contact: Victor Pylro: victor.pylro@gmail.com, Melline Fontes: melfontes@gmail.com, Leandro Lemos: lemosbioinfo@gmail.com or Luiz Roesch: luiz.roesch@gmail.com
#How to use this script?
#perl bmp_demultiplexed.pl -i something.fasta -o something_new.fasta -b Sample_name

use strict;
use warnings;
use Getopt::Std;
use Getopt::Long;

my $inputfile;
my $outputfile;
my $barcode;
my $cont = 0;

Getopt::Long::Configure ('bundling');
GetOptions ('i|input_file=s' => \$inputfile,
	    'o|output_file_prefix=s' => \$outputfile,
	    'b|barcode=s' => \$barcode);

if(!defined($inputfile)) {
    die ("Usage: bmp_demultiplexed.pl -i <input file> -o <output file> -b <Sample name>\n");
}

if(!defined($outputfile)) {
    die ("Usage: bmp_demultiplexed.pl -i <input file> -o <output file> -b <Sample name>\n");
}

if(!defined($barcode)) {
    die ("Usage: bmp_demultiplexed.pl -i <input file> -o <output file> -b <Sample name>\n");
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
    $cont++;
    my $nome = $barcode."_".$cont;
	
    print SAIDA ">$nome;barcodelabel=$barcode\n$sequence\n";
    
}
close(SAIDA);
close(FASTA);
