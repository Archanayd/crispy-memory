#enter metazoa folder, keep all_programs and main hmm resultsfolder one directory out
cat make_dir.txt|xargs mkdir
cp ../all_programs/rename_hmm.pl  plant_hmm_res.txt ids_withspnames 1_rename_hmm/
cd 1_rename_hmm/
mv plant_hmm_res.txt hmm_res_in.txt
perl rename_hmm.pl 
cd ..
cp ../all_programs/split_alignment_files.pl 1_rename_hmm/hmm_alignment.txt 2_alignments/
cd 2_alignments/
perl split_alignment_files.pl 
cd ..
cp ../all_programs/rename_fasta.pl ids_withspnames uniprot.fasta 3_classify/
cd 3_classify/
perl rename_fasta.pl uniprot.fasta 
cd ../
cp ../all_programs/split_fasta.pl 3_classify/fasta_species.txt 4_fasta/
cd 4_fasta
perl split_fasta.pl
ls *[A-Z]* | xargs -I{} cp {} ../5_fasta_highlight1/
ls *[A-Z]* | xargs -I{} cp {} ../8_kix/
cd ../5_fasta_highlight1/
ls *>y
cp y ../8_kix/
cd ../
cp ../all_programs/aa_highlight.pl 2_alignments/*_align.html 5_fasta_highlight1/
cd 5_fasta_highlight1/
ls *.html>x
perl aa_highlight.pl
cp *-fa.html ../6_fasta_highlight2/
cd ../
cp ../all_programs/aa_remove_first.pl 6_fasta_highlight2/
cd 6_fasta_highlight2/
ls *.html>x
perl aa_remove_first.pl 
cp *_fasta.html ../7_highlighted_fasta/
cd ../
cp ../all_programs/Aaa_retrieve_kix.pl 1_rename_hmm/hmm_alignment.txt 8_kix/
cd 8_kix/
cp y x
gsed -i 's/.*/hmm_alignment.txt/' x
cd 8_kix/
mkdir filter
perl Aaa_retrieve_kix.pl
cp *-ki* filter/
cp ../../all_programs/aa_prog.pl filter/
cd filter/
ls *.html>x
mkdir KIX
perl aa_prog.pl 
cp *_kix* KIX/
cd ../../
cp ../all_programs/aa_hmm.pl 2_alignments/*.html 9_refine_hmm/
cd 9_refine_hmm/
mkdir align
ls *_align.html>x
cp x y
gsed -i 's/.*/perl aa_hmm.pl/' y
paste y x>z.sh
chmod +x z.sh
./z.sh
cd ../
cp ../all_programs/ss_prog.pl 8_kix/filter/KIX/*.html 10_sec_str/
cd 10_sec_str/
mkdir sec_str
ls *.html>y
cp y x
gsed -i 's/.*/perl ss_prog.pl/' x
paste x y>z.sh
chmod +x z.sh
./z.sh
cd ../../domain_arrangemnts
mkdir plants
mkdir plants/fasta_without_tags plants/domtblout
cp ../plant_update/4_fasta/* plants/fasta_without_tags/
rm -rf plants/fasta_without_tags/*.txt plants/fasta_without_tags/*.pl
./hmmscan_script_plants.sh
cd plants
mkdir filtered plots
cp ../all_programs/parse* ./
cp ../all_programs/plot* plots
cp ../all_programs/change_fname.sh plots/
./parse_script.sh
cp domtblout/*.out filtered/
cp -r filtered plots/
cd plots
./change_fname.sh
./plot_script.sh
cd ../
mkdir create_table
mkdir create_table/gtfs create_table/tables
mkdir create_table/tables/graphs
cp plots/filtered/*.gtf create_table/gtfs/
cp plots/filtered/*.pdf create_table/tables/graphs/
cp ../all_programs/create_table.sh create_table/
cd create_table/
./create_table.sh


#add anchors and add headers to all files
cd ../../../plants/
mkdir 12_add_anchors
mkdir 12_add_anchors/results 12_add_anchors/tables
cp ../all_programs/add_anchors.pl 12_add_anchors/
cp 7_highlighted_fasta/*.html 12_add_anchors/
cp ../domain_arrangemnts/plants/create_table/tables/*.html 12_add_anchors/tables/
cd 12_add_anchors/
mkdir results/fasta results/tables
ls *.html>y
perl add_anchors.pl
cd ../
mkdir 13_add_headers/
cd 13_add_headers/
cp ../../all_programs/add_header-fasta_plants.pl ../../all_programs/add_header-ss_plants.pl ./
mkdir result kix_seq fasta align clustal sec_str multifeature_plots domain_arrangements
cp ../12_add_anchors/results/fasta/*.html ./
ls *.html>y
cp y x
gsed -i 's/.*/perl add_header-fasta_plants.pl/' x
paste x y>z.sh
chmod +x z.sh 
./z.sh
mv result/* fasta/
rm -rf *.html
cp ../8_kix/filter/KIX/*.html ./
gsed -i 's/_fasta/_kix/' z.sh
./z.sh
mv result/* kix_seq/
rm -rf *.html
cp ../9_refine_hmm/align/*.html ./
gsed -i 's/_kix/_align/' z.sh
./z.sh
mv result/* align/
rm -rf *.html
cp ../12_add_anchors/results/tables/*.html ./
gsed -i 's/_align/_dom/' z.sh
./z.sh
mv result/* domain_arrangements/
rm -rf *.html
cp ../multifeature_plots/plots_htmls/*.html ./
gsed -i 's/_dom/-plot/' z.sh
./z.sh
mv result/* multifeature_plots/
rm -rf *.html
cp ../11_clustal/clustal/*.html ./
ls *.html>y
cp y x
gsed -i 's/.*/perl add_header-ss_plants.pl/' x
paste x y>z.sh
./z.sh
mv result/* clustal/
rm -rf *.html
cp ../10_sec_str/sec_str/*.html ./
rm -rf sec_str.html
ls *.html>y
cp y x
gsed -i 's/.*/perl add_header-ss_plants.pl/' x
paste x y>z.sh
./z.sh
mv result/* sec_str/


