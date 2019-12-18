MOTHUR = code/mothur/mothur
RAW = data/raw/
MOTH = data/mothur/
REFS = data/references/
BASIC_STEM = data/mothur/raw.trim.contigs.good.unique.good.filter.unique.precluster
FIGS = results/figures/
TABLES = results/tables/
PROC = data/process/
FINAL = submission/

# Obtain the Linux version of mothur (v.1.43.0) from the mothur GitHub repository
$(MOTHUR) :
	wget --no-check-certificate https://github.com/mothur/mothur/releases/download/v.1.43.0/Mothur.linux.zip
	unzip Mothur.linux.zip
	mv mothur code/
	rm Mothur.linux.zip
	rm -rf __MACOSX

#########################################################################################
#
# Part 1: Create the reference files
#
# 	We will need several reference files to complete the analyses including the
# SILVA reference alignment and taxonomy. As we are analyzing both Bacteria and
# Archaea we need to optimize the procedure described on the mothur blog
# (http://blog.mothur.org/2018/01/10/SILVA-v132-reference-files/).
#
#########################################################################################

# We want the latest greatest reference alignment and the SILVA reference
# alignment is the best reference alignment on the market. We will use the 
# version 132. The curation of the reference files to make them compatible with 
# mothur is described at http://blog.mothur.org/2018/01/10/SILVA-v132-reference-files/
# As we are using the primers from the Earth Microbiome Project that are targeting
# both Bacteria and Archaea (http://www.earthmicrobiome.org/protocols-and-standards/16s/)
# we need to modify the procedure described at
# http://blog.mothur.org/2018/01/10/SILVA-v132-reference-files/
# as this approach is removing shorter archeal sequences.
# 
# The SILVA Release 132 was downloaded from 
# https://www.arb-silva.de/fileadmin/arb_web_db/release_132/ARB_files/SILVA_132_SSURef_NR99_13_12_17_opt.arb.gz
# opened with ARB and exported to silva.full_v132.fasta file as described at
# http://blog.mothur.org/2018/01/10/SILVA-v132-reference-files/ uder the 
# section Getting the data in and out of the ARB database. A total of 629,211
# sequences were exported.

# Screening the sequences
$(REFS)silva.nr_v132.align : $(MOTHUR)\
                             ~/silva.full_v132/silva.full_v132.fasta
	cp ~/silva.full_v132/silva.full_v132.fasta $(REFS)silva.full_v132.fasta
	$(MOTHUR) "#set.dir(input=$(REFS), output=$(REFS));\
	            screen.seqs(fasta=$(REFS)silva.full_v132.fasta, start=11894, end=25319, maxambig=5, processors=16)"
	# Generate alignment file
	mv $(REFS)silva.full_v132.good.fasta $(REFS)silva.nr_v132.align

# Generate taxonomy file
$(REFS)silva.nr_v132.full : $(REFS)silva.nr_v132.align\
                            $(MOTHUR)
	grep '>' $(REFS)silva.nr_v132.align | cut -f 1,3 | cut -f 2 -d '>' > $(REFS)silva.nr_v132.full

# Formatting the taxonomy files
$(REFS)silva.nr_v132.tax : code/format_taxonomy.R\
                           $(REFS)silva.nr_v132.full
	wget https://www.arb-silva.de/fileadmin/silva_databases/current/Exports/taxonomy/tax_slv_ssu_132.txt
	mv tax_slv_ssu_132.txt $(REFS)tax_slv_ssu_132.txt
	R -e "source('code/format_taxonomy.R')"
	mv $(REFS)silva.full_v132.tax $(REFS)silva.nr_v132.tax

# Trimming the database to the region of interest (V4 region)
$(REFS)silva.nr_v132.pcr%align\
$(REFS)silva.nr_v132.pcr.unique%align : $(REFS)silva.nr_v132.align\
                                        $(MOTHUR)
	$(MOTHUR) "#set.dir(input=$(REFS), output=$(REFS));\
	            pcr.seqs(fasta=$(REFS)silva.nr_v132.align, start=11894, end=25319, keepdots=F, processors=16);\
	            unique.seqs()"

#########################################################################################
#
# Part 2: Run data through mothur and get the sequencing error
#
# 	Process fastq data through the generation of files that will be used in the
# overall analysis.
#
#########################################################################################

$(RAW)raw.files : $(RAW)metadata.csv
	cut -f 1,5,6 data/raw/metadata.csv | tail -n +2 > $(RAW)raw.files

$(RAW)*.fastq : $(RAW)raw.files\
                ~/raw/together/*.fastq
	(cut -f 2 $(RAW)raw.files; cut -f 3 $(RAW)raw.files) | cat > $(RAW)names_file.txt
	xargs -I % --arg-file=$(RAW)names_file.txt cp ~/raw/together/% -t $(RAW)	

# Here we go from the raw fastq files and the files file to generate a fasta,
# taxonomy, and count_table file that has had the chimeras removed as well as
# any non bacterial or archeal sequences.
# The raw data (.fastq files) should be locateted in data/raw/

# Add a primer.oligos file containing the sequences of the gene speciic primers
$(MOTH)raw.trim.contigs%fasta\
$(MOTH)raw.trim.contigs.good.unique%fasta\
$(MOTH)raw.trim.contigs.good%count_table\
$(MOTH)raw.trim.contigs.good%unique.align\
$(MOTH)raw.trim.contigs.good%unique.good.align\
$(MOTH)raw.trim.contigs.good.good%count_table\
$(BASIC_STEM).pick%fasta\
$(BASIC_STEM).denovo.vsearch.pick%count_table\
$(BASIC_STEM).pick.pick%fasta\
$(BASIC_STEM).denovo.vsearch.pick.pick%count_table\
$(BASIC_STEM).pick.nr_v132.wang.pick%taxonomy\
$(BASIC_STEM).pick.nr_v132.wang.tax%summary\
$(MOTH)chloroplast%fasta\
$(MOTH)chloroplast%count_table\
$(MOTH)chloroplast%taxonomy : code/get_good_seqs.batch\
                              $(RAW)raw.files\
                              $(RAW)primer.oligos\
                              $(RAW)*.fastq\
                              $(REFS)silva.nr_v132.pcr.align\
                              $(REFS)silva.nr_v132.pcr.unique.align\
                              $(REFS)silva.nr_v132.tax\
                              $(MOTHUR)
	$(MOTHUR) code/get_good_seqs.batch
	rm data/mothur/*.map

# Create a summary.txt file to check that all went alright throughout the code/get_good_seqs.batch
data/summary.txt : $(REFS)silva.nr_v132.pcr.align\
                   $(REFS)silva.nr_v132.pcr.unique.align\
                   $(MOTH)raw.trim.contigs.fasta\
                   $(MOTH)raw.trim.contigs.good.unique.fasta\
                   $(MOTH)raw.trim.contigs.good.count_table\
                   $(MOTH)raw.trim.contigs.good.unique.align\
                   $(MOTH)raw.trim.contigs.good.unique.good.align\
                   $(MOTH)raw.trim.contigs.good.good.count_table\
                   $(BASIC_STEM).pick.fasta\
                   $(BASIC_STEM).denovo.vsearch.pick.count_table\
                   $(BASIC_STEM).pick.pick.fasta\
                   $(BASIC_STEM).denovo.vsearch.pick.pick.count_table\
                   $(MOTHUR)
	$(MOTHUR) code/get_summary.batch

# Here we go from the good sequences and generate a shared file and a
# cons.taxonomy file based on OTU data. In addition, we are binning
# the sequences in to phylotypes according to their taxonomic classification.

# Edit code/get_shared_otus.batch to include the proper root name of your files file.
# Edit code/get_shared_otus.batch to include the proper group names to remove.
$(BASIC_STEM).pick.pick.pick.opti_mcc%shared\
$(BASIC_STEM).pick.pick.pick.opti_mcc.unique_list.0.03.cons%taxonomy\
$(BASIC_STEM).precluster.pick.nr_v132.wang.pick.pick.tx%shared\
$(BASIC_STEM).precluster.pick.nr_v132.wang.pick.pick.tx.1.cons%taxonomy\
$(BASIC_STEM).precluster.pick.nr_v132.wang.pick.pick.tx.2.cons%taxonomy\
$(BASIC_STEM).precluster.pick.nr_v132.wang.pick.pick.tx.3.cons%taxonomy\
$(BASIC_STEM).precluster.pick.nr_v132.wang.pick.pick.tx.4.cons%taxonomy\
$(BASIC_STEM).precluster.pick.nr_v132.wang.pick.pick.tx.5.cons%taxonomy\
$(BASIC_STEM).precluster.pick.nr_v132.wang.pick.pick.tx.6.cons%taxonomy : code/get_shared_otus.batch\
                                                                          $(BASIC_STEM).pick.pick.fasta\
                                                                          $(BASIC_STEM).denovo.vsearch.pick.pick.count_table\
                                                                          $(BASIC_STEM).pick.nr_v132.wang.pick.taxonomy\
                                                                          $(MOTHUR)
	$(MOTHUR) code/get_shared_otus.batch
	$(MOTHUR) code/get_shared_phylotypes.batch
	rm $(BASIC_STEM).denovo.vsearch.pick.pick.pick.count_table
	rm $(BASIC_STEM).pick.pick.pick.fasta
	rm $(BASIC_STEM).pick.nr_v132.wang.pick.pick.taxonomy

# Now we want to get the sequencing error as seen in the mock community samples.
# Edit code/get_error.batch to include the proper group names for your mocks.
$(BASIC_STEM).pick.pick.pick.error.summary : code/get_error.batch\
                                             $(BASIC_STEM).pick.pick.fasta\
                                             $(BASIC_STEM).denovo.vsearch.pick.pick.count_table\
                                             $(REFS)atcc_v4.fasta\
                                             $(MOTHUR)
	$(MOTHUR) code/get_error.batch

#########################################################################################
#
# Part 3: Figure and table generation
#
# 	Run scripts to generate figures and tables
#
#########################################################################################

# Generate a community composition bar plot
$(FIGS)community_bar_plot.jpg : code/plot_community_bar_plot.R\
                                $(BASIC_STEM).pick.nr_v132.wang.tax.summary\
                                $(RAW)metadata.csv\
                                $(RAW)group_colors.csv
	R -e "source('code/plot_community_bar_plot.R')"

# Generate rarefaction data
$(BASIC_STEM).pick.pick.pick.opti_mcc.groups.rarefaction : $(BASIC_STEM).pick.pick.pick.opti_mcc.shared\
                                                           code/get_rarefaction_data.batch\
                                                           $(MOTHUR)
	$(MOTHUR) code/get_rarefaction_data.batch

# Construct a rarefaction plot
$(FIGS)rarefaction.jpg : code/plot_rarefaction.R\
                         $(RAW)metadata.csv\
                         $(BASIC_STEM).pick.pick.pick.opti_mcc.groups.rarefaction
	R -e "source('code/plot_rarefaction.R')"

# Determine community richness and diversity calculators   
$(BASIC_STEM).pick.pick.pick.opti_mcc.groups.ave-std.summary : $(BASIC_STEM).pick.pick.pick.opti_mcc.shared\
                                                               code/get_calculators.batch\
                                                               $(MOTHUR)
	$(MOTHUR) code/get_calculators.batch

# Plot richness and diversity calculators
$(FIGS)calculators.jpg : code/plot_calculators.R\
                          $(RAW)metadata.csv\
                          $(BASIC_STEM).pick.pick.pick.opti_mcc.groups.ave-std.summary
	R -e "source('code/plot_calculators.R')"

# Generate data to plot PCoA ordination
$(BASIC_STEM).pick.pick.pick.opti_mcc.braycurtis.0.03.lt.ave.pcoa%axes\
$(BASIC_STEM).pick.pick.pick.opti_mcc.braycurtis.0.03.lt.ave.pcoa%loadings : code/get_pcoa_data.batch\
                                                                             $(BASIC_STEM).pick.pick.pick.opti_mcc.shared\
                                                                             $(MOTHUR)
	$(MOTHUR) code/get_pcoa_data.batch

# Construct a PCoA plot
$(FIGS)pcoa_figure.jpg : code/plot_pcoa.R\
                         $(BASIC_STEM).pick.pick.pick.opti_mcc.braycurtis.0.03.lt.ave.pcoa.axes\
                         $(BASIC_STEM).pick.pick.pick.opti_mcc.braycurtis.0.03.lt.ave.pcoa.loadings\
                         $(RAW)metadata.csv
	R -e "source('code/plot_pcoa.R')"

#########################################################################################
#
# Part 4: Combaine all together
#
# 	Render the manuscript
#
#########################################################################################

$(FINAL)manuscript.pdf : data/summary.txt\
                         $(BASIC_STEM).pick.pick.pick.error.summary\
                         $(FIGS)community_barplot_phylum.jpg\
                         $(FIGS)rarefaction.jpg\
                         $(FIGS)calculators.jpg\
                         $(FIGS)pcoa_figure.jpg\
                         $(FINAL)manuscript.Rmd\
                         $(FINAL)header.tex\
                         $(FINAL)references.bib\
                         $(FINAL)citation_style.csl
	R -e 'render("$(FINAL)manuscript.Rmd", clean=FALSE)'
	mv $(FINAL)manuscript.knit.md $(FINAL)manuscript.md
	rm $(FINAL)manuscript.utf8.md

# Cleaning
.PHONY: clean
clean :
	rm -f my_job.qsub.* || true
#	rm -f $(REFS)tax* || true
#	rm -f $(REFS)silva* || true
	rm -f $(MOTH)* || true
	rm -f data/summary.txt || true
	rm -f $(RAW)*.fastq || true
	rm -f $(RAW)names_file.txt || true
	rm -f $(RAW)raw.files || true
	rm -rf code/mothur/ || true
	rm -f $(FIGS)* || true
	rm -f mothur*logfile || true